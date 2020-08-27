require_relative "test_helper"

class TestClient
  include Thrift::Client
end

class ThriftClientTest < Minitest::Test
  def test_connect
    client = ThriftClient.new(TestClient, "#{connect_host}:9160", retries: 0, connect_timeout: 1)
    assert_timeout(ThriftClient::NoServersAvailable) do
      client.connect!
    end
  end

  def test_read
    skip "TODO"

    client = ThriftClient.new(TestClient, read_host_and_port, retries: 0, timeout: 1)
    assert_timeout(Thrift::TransportException) do
    end
  end
end
