require_relative "test_helper"

class BitlyTest < Minitest::Test
  def test_connect
    skip "Needs updated for latest version"

    assert_timeout(BitlyTimeout) do
      Bitly::API::Client.new("username", "api_key", 1).info("http://bit.ly/wQaT")
    end
  end

  def test_read
    skip "Needs updated for latest version"

    assert_timeout(BitlyTimeout) do
      Bitly::API::Client.new("username", "api_key", 1).info("http://bit.ly/wQaT")
    end
  end
end
