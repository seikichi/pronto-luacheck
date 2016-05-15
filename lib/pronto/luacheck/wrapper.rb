require 'open3'
require 'rexml/document'

module Pronto
  module Luacheck
    class Wrapper
      def initialize
        @luacheck_path = ENV['PRONTO_LUACHECK_PATH'] || 'luacheck'
      end

      def run(filepath)
        stdout, stderr, = run_luacheck(filepath)
        puts "WARN: pronto-luacheck: #{stderr}" if stderr && !stderr.empty?
        return [] if stdout.nil? || stdout == 0
        parse_output(stdout)
      end

      private

      def parse_output(output)
        doc = REXML::Document.new(output)

        result = []
        REXML::XPath.match(doc, '//testcase').each do |testcase|
          file = testcase.attributes['classname']
          next if testcase.elements.size != 1

          failure = testcase.elements.first
          md = failure.attributes['message']
               .match(/\A#{Regexp.escape(file)}:(?<line>\d+):(?<column>\d+):\s+(?<message>.*)\z/)
          next unless md

          result << {
            file: file,
            line: md[:line].to_i,
            column: md[:column].to_i,
            level: level(failure),
            message: md[:message],
            rule: rule(failure)
          }
        end

        result
      end

      def run_luacheck(path)
        Open3.capture3("#{@luacheck_path.shellescape} --formatter=JUnit #{path.shellescape}")
      end

      def rule(failure)
        type = failure.attributes['type']
        type[1..-1]
      end

      def level(failure)
        type = failure.attributes['type']
        return :warning if type.start_with?('W')
        return :error if type.start_with?('E')
        :info
      end
    end
  end
end
