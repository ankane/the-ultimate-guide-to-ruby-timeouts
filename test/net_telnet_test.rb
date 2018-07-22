require_relative "test_helper"

class NetTelnetTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Net::Telnet::new("Host" => connect_host, "Timeout" => 1)
    end
  end

  def test_read
    telnet = Net::Telnet::new("Host" => read_host, "Port" => read_port, "Timeout" => 1)
    assert_timeout(Net::ReadTimeout) do
      telnet.login("user", "password")
    end
  end
end
