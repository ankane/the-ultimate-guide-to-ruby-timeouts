require_relative "test_helper"

class SavonTest < Minitest::Test
  def test_connect
    client = Savon.client(wsdl: connect_url, open_timeout: 1)

    assert_timeout(HTTPClient::ConnectTimeoutError) do
      client.operations
    end
  end

  def test_read
    client = Savon.client(wsdl: read_url, read_timeout: 1)

    assert_timeout(HTTPClient::ReceiveTimeoutError) do
      client.operations
    end
  end
end
