require_relative "test_helper"
require "coinbase/wallet"

class CoinbaseTest < Minitest::Test
  def test_connect
    skip

    client = Coinbase::Wallet::Client.new(
      api_url: connect_url,
      api_key: "key",
      api_secret: "secret"
    )
  end

  def test_read
    skip
  end
end
