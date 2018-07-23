require_relative "test_helper"

class ReversedTest < Minitest::Test
  def test_connect
    assert_nil Reversed.lookup("8.8.8.8", timeout: 1, nameservers: [connect_host])
  end

  def test_read
    skip # no way to set port

    assert_nil Reversed.lookup("8.8.8.8", timeout: 1, nameservers: [read_host])
  end
end
