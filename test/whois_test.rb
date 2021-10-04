require_relative "test_helper"

class WhoisTest < Minitest::Test
  def test_connect
    assert_timeout(Timeout::Error) do
      Whois::Client.new(host: connect_host, timeout: 1).lookup("example.com")
    end
  end

  def test_read
    assert_timeout(Timeout::Error) do
      Whois::Client.new(host: read_host, port: read_port, timeout: 1).lookup("example.com")
    end
  end
end
