require_relative "test_helper"

class SiftTest < Minitest::Test
  def test_connect
    Sift::Client.base_uri connect_url

    client = Sift::Client.new(api_key: "test", account_id: "test", timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.score("1")
    end
  end

  def test_read
    Sift::Client.base_uri read_url

    client = Sift::Client.new(api_key: "test", account_id: "test", timeout: 1)
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      client.score("1")
    end
  end
end
