require_relative "test_helper"

class SodaRubyTest < Minitest::Test
  def test_connect
    skip # requires https endpoint

    client = SODA::Client.new(domain: connect_host, timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.get("test")
    end
  end

  def test_read
    skip # requires https endpoint

    client = SODA::Client.new(domain: read_host_and_port, timeout: 1)
    assert_timeout(Net::ReadTimeout) do
      client.get("test")
    end
  end
end
