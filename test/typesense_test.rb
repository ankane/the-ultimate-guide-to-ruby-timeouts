require_relative "test_helper"

class TypesenseTest < Minitest::Test
  def test_connect
    client = Typesense::Client.new(
      nodes: [{host: connect_host, port: 80, protocol: "http"}],
      api_key:  "secret",
      connection_timeout_seconds: 1,
      num_retries: 0
    )
    assert_timeout(Net::OpenTimeout) do
      client.collections.retrieve
    end
  end

  def test_read
    client = Typesense::Client.new(
      nodes: [{host: read_host, port: read_port, protocol: "http"}],
      api_key:  "secret",
      connection_timeout_seconds: 1,
      num_retries: 0
    )
    assert_timeout(Net::ReadTimeout) do
      client.collections.retrieve
    end
  end
end
