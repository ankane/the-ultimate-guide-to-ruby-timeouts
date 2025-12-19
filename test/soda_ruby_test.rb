require_relative "test_helper"

class SodaRubyTest < Minitest::Test
  def test_connect
    client = SODA::Client.new(domain: connect_host, timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.get("test")
    end
  end

  def test_read
    skip "No way to set port and requires ssl"

    client = SODA::Client.new(timeout: 1)
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      # requires https endpoint
      client.get("https://httpbin.org/delay/3")
    end
  end
end
