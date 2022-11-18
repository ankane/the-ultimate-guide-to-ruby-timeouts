require_relative "test_helper"
require "net/http"

class BitlyTest < Minitest::Test
  def test_connect
    Bitly::API.send(:remove_const, "BASE_URL")
    Bitly::API.const_set("BASE_URL", URI(connect_url))

    assert_timeout(Net::OpenTimeout) do
      adapter = Bitly::HTTP::Adapters::NetHTTP.new(request_opts: { open_timeout: 1 })
      http_client = Bitly::HTTP::Client.new(adapter)
      Bitly::API::Client.new(token: "123", http: http_client).shorten(long_url: "http://bit.ly/wQaT")
    end
  end

  def test_read
    Bitly::API.send(:remove_const, "BASE_URL")
    Bitly::API.const_set("BASE_URL", URI(read_url))

    assert_timeout(Net::ReadTimeout) do
      adapter = Bitly::HTTP::Adapters::NetHTTP.new(request_opts: { read_timeout: 1, use_ssl: false })
      http_client = Bitly::HTTP::Client.new(adapter)
      Bitly::API::Client.new(token: "123", http: http_client).shorten(long_url: "http://bit.ly/wQaT")
    end
  end
end
