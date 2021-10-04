require_relative "test_helper"

class NetNtpTest < Minitest::Test
  def test_connect
    assert_timeout(Timeout::Error) do
      Net::NTP.get(connect_host, 80, 1)
    end
  end

  def test_read
    skip "Uses UPD"

    assert_timeout(Timeout::Error) do
      Net::NTP.get(read_host, read_port, 1)
    end
  end
end
