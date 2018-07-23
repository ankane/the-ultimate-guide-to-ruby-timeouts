require_relative "test_helper"

class ActiveShippingTest < Minitest::Test
  def test_connect
    ActiveShipping::USPS::USE_SSL[:test] = false
    ActiveShipping::USPS::TEST_DOMAINS[false] = connect_host

    client = ActiveShipping::USPS.new(login: "developer-key", test: true)
    client.open_timeout = 1
    client.max_retries = 1
    assert_timeout(ActiveUtils::ConnectionError) do
      client.find_tracking_info("123")
    end
  end

  def test_read
    ActiveShipping::USPS::USE_SSL[:test] = false
    ActiveShipping::USPS::TEST_DOMAINS[false] = read_host_and_port

    client = ActiveShipping::USPS.new(login: "developer-key", test: true)
    client.read_timeout = 1
    client.max_retries = 1
    assert_timeout(ActiveUtils::ConnectionError) do
      client.find_tracking_info("123")
    end
  end
end
