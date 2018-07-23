require_relative "test_helper"

class CouchrestTest < Minitest::Test
  def test_connect
    assert_timeout(HTTPClient::ConnectTimeoutError) do
      CouchRest.new(connect_url, open_timeout: 1).databases
    end
  end

  def test_read
    assert_timeout(HTTPClient::ReceiveTimeoutError) do
      CouchRest.new(read_url, timeout: 1).databases
    end
  end
end
