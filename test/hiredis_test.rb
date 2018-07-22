require_relative "test_helper"

class HiredisTest < Minitest::Test
  def test_connect
    conn = Hiredis::Connection.new
    conn.timeout = 1_000_000
    assert_timeout(Errno::ETIMEDOUT) do
      conn.connect(connect_host, 6379)
    end
  end

  def test_read
    conn = Hiredis::Connection.new
    conn.timeout = 1_000_000
    assert_timeout(Errno::EAGAIN) do
      conn.connect(read_host, read_port)
      conn.write ["GET", "speed"]
      conn.read
    end
  end
end
