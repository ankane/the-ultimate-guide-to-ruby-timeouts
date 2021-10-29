require_relative "test_helper"

class BoxrTest < Minitest::Test
  def test_connect
    Boxr::Client.send(:remove_const, "FOLDERS_URI")
    Boxr::Client.const_set("FOLDERS_URI", connect_url)
    Boxr::BOX_CLIENT.connect_timeout = 1
    client = Boxr::Client.new("token")

    assert_timeout(HTTPClient::ConnectTimeoutError) do
      client.folder_items(Boxr::ROOT)
    end
  end

  def test_read
    Boxr::Client.send(:remove_const, "FOLDERS_URI")
    Boxr::Client.const_set("FOLDERS_URI", read_url)
    Boxr::BOX_CLIENT.receive_timeout = 1
    client = Boxr::Client.new("token")

    assert_timeout(HTTPClient::ReceiveTimeoutError) do
      client.folder_items(Boxr::ROOT)
    end
  end
end
