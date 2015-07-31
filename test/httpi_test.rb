require_relative "test_helper"

class HttpiClientTest < Minitest::Test
  def test_connect
    assert_timeout(HTTPClient::ConnectTimeoutError) do
      HTTPI.get(HTTPI::Request.new(url: connect_url, open_timeout: 1))
    end
  end

  def test_read
    assert_timeout(HTTPClient::ReceiveTimeoutError) do
      HTTPI.get(HTTPI::Request.new(url: read_url, read_timeout: 1))
    end
  end
end
