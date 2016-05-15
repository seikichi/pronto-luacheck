# coding: UTF-8

class TestLuacheckRunner < Test::Unit::TestCase
  test '#run returns empty array when patches are nil' do
    runner = Pronto::LuacheckRunner.new(nil)
    assert_equal([], runner.run)
  end

  test '#run returns empty array when no patches' do
    runner = Pronto::LuacheckRunner.new([])
    assert_equal([], runner.run)
  end

  test '#run ignores not added files' do
    patch = Pronto::Git::Patch.new
    mock(patch).additions { 0 }

    runner = Pronto::LuacheckRunner.new([patch])
    assert_equal([], runner.run)
  end

  test '#run ignores not lua files' do
    patch = Pronto::Git::Patch.new
    mock(patch).additions { 1 }
    mock(patch).new_file_full_path { Pathname.new('/foo') }

    runner = Pronto::LuacheckRunner.new([patch])
    assert_equal([], runner.run)
  end
end
