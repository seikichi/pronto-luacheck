# coding: UTF-8

class TestLuacheckWrapper < Test::Unit::TestCase
  test '#run parses luacheck output correctly' do
    luacheck = Pronto::Luacheck::Wrapper.new
    stub(luacheck).run_luacheck do |_|
      <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="Luacheck report" tests="1">
  <testcase name="foo.lua:1" classname="foo.lua">
    <failure type="W111" message="foo.lua:1:1: setting non-standard global variable 'foo'"/>
  </testcase>
</testsuite>
EOF
    end

    actual = luacheck.run('/foo.lua')
    expected = [
      {
        file: 'foo.lua',
        line: 1,
        column: 1,
        level: :warning,
        message: 'setting non-standard global variable \'foo\'',
        rule: '111'
      }
    ]
    assert_equal(expected, actual)
  end
end
