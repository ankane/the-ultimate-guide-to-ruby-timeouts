require_relative "test_helper"

class RestClientTest < Minitest::Test
  def test_connect
    assert_timeout(RestClient::RequestTimeout) do
      RestClient::Request.execute(method: :get, url: connect_url, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(RestClient::RequestTimeout) do
      RestClient::Request.execute(method: :get, url: read_url, timeout: 1)
    end
  end
end
