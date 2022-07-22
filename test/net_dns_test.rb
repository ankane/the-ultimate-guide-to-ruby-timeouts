require_relative "test_helper"

# for https://github.com/bluemonk/net-dns/issues/82
require "timeout"
TimeoutError = Timeout::Error

require "net/dns"

class NetDnsTest < Minitest::Test
  def test_connect_udp
    assert_timeout(Net::DNS::Resolver::NoResponseError) do
      Net::DNS::Resolver.new(nameservers: [connect_host], udp_timeout: 1).search("8.8.4.4")
    end
  end

  def test_read_udp
    assert_timeout(Net::DNS::Resolver::NoResponseError) do
      Net::DNS::Resolver.new(nameservers: [read_host], port: read_port, udp_timeout: 1).search("8.8.4.4")
    end
  end
end
