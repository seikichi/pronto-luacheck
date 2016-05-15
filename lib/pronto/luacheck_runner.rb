require 'pronto'

require_relative 'luacheck/wrapper'

module Pronto
  class LuacheckRunner < Runner
    def initialize(_, __ = nil)
      super

      @inspector = ::Pronto::Luacheck::Wrapper.new
    end

    def run
      return [] unless @patches

      @patches.select { |patch| valid_patch?(patch) }
              .map { |patch| inspect(patch) }
              .flatten
              .compact
    end

    private

    def valid_patch?(patch)
      return false if patch.additions < 1

      lua_file?(patch)
    end

    def lua_file?(patch)
      patch.new_file_full_path.to_s.end_with?('.lua')
    end

    def inspect(patch)
      offences = @inspector.run(patch.new_file_full_path.to_s)
      offences.map do |offence|
        patch.added_lines
             .select { |line| line.new_lineno == offence[:line] }
             .map { |line| new_message(offence, line) }
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      Message.new(path, line, offence[:level], offence[:message], nil, self.class)
    end
  end
end
