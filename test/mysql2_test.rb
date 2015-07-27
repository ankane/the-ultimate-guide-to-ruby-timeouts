require_relative "test_helper"

class Mysql2Test < Minitest::Test
  def test_connect
    assert_timeout(Mysql2::Error) do
      Mysql2::Client.new(host: connect_host, connect_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Mysql2::Error) do
      Mysql2::Client.new(host: read_host, port: read_port, connect_timeout: 1).query("SELECT 1")
    end
  end
end
