require_relative "test_helper"

class HttpClientTest < Minitest::Test
  def test_connect
    assert_timeout(HTTPClient::ConnectTimeoutError) do
      client = HTTPClient.new
      client.connect_timeout = 1
      client.get(connect_url)
    end
  end

  def test_read
    assert_timeout(HTTPClient::ReceiveTimeoutError) do
      client = HTTPClient.new
      client.receive_timeout = 1
      client.get(read_url)
    end
  end
end
