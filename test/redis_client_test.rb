require_relative "test_helper"

class RedisClientTest < Minitest::Test
  def test_connect
    assert_timeout(RedisClient::CannotConnectError) do
      RedisClient.config(host: connect_host, connect_timeout: 1, reconnect_attempts: 0).new_client.call("PING")
    end
  end

  def test_read
    assert_timeout(RedisClient::CannotConnectError) do
      RedisClient.config(host: read_host, port: read_port, read_timeout: 1, reconnect_attempts: 0).new_client.call("PING")
    end
  end

  def test_timeout
    assert_timeout(RedisClient::CannotConnectError) do
      RedisClient.config(host: connect_host, timeout: 1, reconnect_attempts: 0).new_client.call("PING")
    end
  end
end
