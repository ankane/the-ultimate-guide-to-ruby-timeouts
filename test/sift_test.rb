require_relative "test_helper"

class SiftTest < Minitest::Test
  def test_connect
    Sift::Client.send(:remove_const, "API_ENDPOINT")
    Sift::Client.const_set("API_ENDPOINT", connect_url)
    Sift::Client.remove_instance_variable(:@api_client) rescue nil

    client = Sift::Client.new(api_key: "test", account_id: "test", timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.score("1")
    end
  end

  def test_read
    Sift::Client.send(:remove_const, "API_ENDPOINT")
    Sift::Client.const_set("API_ENDPOINT", read_url)
    Sift::Client.remove_instance_variable(:@api_client) rescue nil

    client = Sift::Client.new(api_key: "test", account_id: "test", timeout: 1)
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      client.score("1")
    end
  end
end
