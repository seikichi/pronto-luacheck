require 'test_helper'

module Pronto
  class LuacheckTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Pronto::Luacheck::VERSION
    end
  end
end
