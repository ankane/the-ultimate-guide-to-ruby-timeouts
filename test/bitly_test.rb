require_relative "test_helper"
Bitly.use_api_version_3

class BitlyTest < Minitest::Test
  def test_connect
    Bitly::V3::Client.base_uri connect_url
    assert_timeout(BitlyTimeout) do
      Bitly.new("username", "api_key", 1).info("http://bit.ly/wQaT")
    end
  end

  def test_read
    Bitly::V3::Client.base_uri read_url
    assert_timeout(BitlyTimeout) do
      Bitly.new("username", "api_key", 1).info("http://bit.ly/wQaT")
    end
  end
end
