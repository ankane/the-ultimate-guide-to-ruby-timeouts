require_relative "test_helper"

class StripeTest < Minitest::Test
  def setup
    Stripe.api_key = "boom"
    Stripe.max_network_retries = 0
  end

  def test_connect
    Stripe.api_base = connect_url
    Stripe.open_timeout = 1
    assert_timeout(Stripe::APIConnectionError) do
      Stripe::Customer.list
    end
  end

  def test_read
    Stripe.api_base = read_url
    Stripe.read_timeout = 1
    assert_timeout(Stripe::APIConnectionError, timeout: 2) do
      Stripe::Customer.list
    end
  end
end
