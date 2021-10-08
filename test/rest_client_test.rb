require_relative "test_helper"

class RestClientTest < Minitest::Test
  def test_connect
    assert_timeout(RestClient::Exceptions::OpenTimeout) do
      RestClient::Request.execute(method: :get, url: connect_url, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(RestClient::Exceptions::ReadTimeout, timeout: 2) do
      RestClient::Request.execute(method: :get, url: read_url, read_timeout: 1)
    end
  end
end
