require_relative "test_helper"

ActiveMerchant::Billing::Gateway.open_timeout = 1 # Default is 60
ActiveMerchant::Billing::Gateway.read_timeout = 1 # Default is 60
ActiveMerchant::Billing::Gateway.max_retries = 0 # Default is 3

class ActivemerchantTest < Minitest::Test
  def setup
    @stripe = ActiveMerchant::Billing::StripeGateway.new(login: "bogus")
  end

  def test_connect
    @stripe.live_url = connect_url + "/"
    assert_timeout(ActiveMerchant::ConnectionError) do
      @stripe.verify_credentials
    end
  end

  def test_read
    @stripe.live_url = read_url + "/"
    assert_timeout(ActiveMerchant::ConnectionError) do
      @stripe.verify_credentials
    end
  end
end
