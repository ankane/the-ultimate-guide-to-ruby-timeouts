require_relative "test_helper"

class ConnectionPoolTest < Minitest::Test
  def test_connect
    pool = ConnectionPool.new(size: 1, timeout: 1) { Redis.new(host: read_host, port: read_port) }
    assert_threaded_timeout(Timeout::Error) do
      pool.with { |redis| redis.ping }
    end
  end
end
