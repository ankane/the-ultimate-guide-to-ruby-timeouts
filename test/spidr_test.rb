require_relative "test_helper"

class SpidrTest < Minitest::Test
  def test_connect
    Spidr.open_timeout = 1
    assert Spidr.site(connect_url).failures.any?
  end

  def test_read
    Spidr.read_timeout = 1
    assert Spidr.site(read_url).failures.any?
  end
end
