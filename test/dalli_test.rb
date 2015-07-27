require_relative "test_helper"

class DalliTest < Minitest::Test
  def test_connect
    assert_timeout(Dalli::RingError) { Dalli::Client.new(connect_host, socket_timeout: 1).get("hi") }
  end

  def test_connect_default
    assert_timeout(Dalli::RingError, timeout: 0.5) { Dalli::Client.new(connect_host).get("hi") }
  end

  def test_read
    assert_timeout(Dalli::RingError) { Dalli::Client.new(read_host_and_port, socket_timeout: 1).get("hi") }
  end
end
