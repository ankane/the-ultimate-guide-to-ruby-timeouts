require_relative "test_helper"

class RedisTest < Minitest::Test
  def test_connect
    assert_timeout(Redis::CannotConnectError) { Redis.new(host: connect_host, connect_timeout: 1).ping }
  end

  def test_read
    assert_timeout(Redis::TimeoutError) { Redis.new(host: read_host, port: read_port, timeout: 1).ping }
  end
end
