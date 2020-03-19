require_relative "test_helper"

class BitlyTest < Minitest::Test
  def test_connect
    skip "Not configurable"

    Bitly::API.send(:remove_const, "BASE_URL")
    Bitly::API.const_set("BASE_URL", URI(connect_url))

    # assert_timeout(BitlyTimeout) do
    #   Bitly::API::Client.new(token: "123").shorten(long_url: "http://bit.ly/wQaT")
    # end
  end

  def test_read
    skip "Not configurable"

    Bitly::API.send(:remove_const, "BASE_URL")
    Bitly::API.const_set("BASE_URL", URI(read_url))

    # assert_timeout(BitlyTimeout) do
    #   Bitly::API::Client.new(token: "123").shorten(long_url: "http://bit.ly/wQaT")
    # end
  end
end
