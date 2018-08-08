require_relative "test_helper"

class ConnectionPoolTest < Minitest::Test
  def test_connect
    pool = ConnectionPool.new(size: 1, timeout: 1) { Redis.new }
    assert_threaded_timeout(Timeout::Error) do
      pool.with { |_| sleep(2) }
    end
  end
end
