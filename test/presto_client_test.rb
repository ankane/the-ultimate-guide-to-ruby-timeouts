require_relative "test_helper"

class PrestoClientTest < Minitest::Test
  def test_connect
    client = Presto::Client.new(server: connect_host, http_open_timeout: 1)
    assert_timeout(Faraday::ConnectionFailed) do
      client.run("select * from sys.node")
    end
  end

  def test_read
    client = Presto::Client.new(server: read_host_and_port, http_timeout: 1)
    assert_timeout(Faraday::TimeoutError) do
      client.run("select * from sys.node")
    end
  end
end
