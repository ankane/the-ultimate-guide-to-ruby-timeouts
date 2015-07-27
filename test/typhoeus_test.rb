require_relative "test_helper"

class TyphoeusTest < Minitest::Test
  def test_connect
    assert Typhoeus.get(connect_url, timeout: 1).timed_out?
    assert Typhoeus.get(connect_url, connecttimeout: 1).timed_out?
  end

  def test_read
    assert Typhoeus.get(read_url, timeout: 1).timed_out?
  end
end
