require_relative "test_helper"

# for https://github.com/bluemonk/net-dns/issues/82
require "timeout"
TimeoutError = Timeout::Error

class ReversedTest < Minitest::Test
  def test_connect
    assert_nil Reversed.lookup("8.8.8.8", timeout: 1, nameservers: [connect_host])
  end

  def test_read
    skip "No way to set port"

    assert_nil Reversed.lookup("8.8.8.8", timeout: 1, nameservers: [read_host])
  end
end
