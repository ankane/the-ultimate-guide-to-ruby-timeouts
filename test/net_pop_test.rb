require_relative "test_helper"
require "net/pop"

class NetImapTest < Minitest::Test
  def test_connect
    pop = Net::POP.new(connect_host)
    pop.open_timeout = 1
    assert_timeout(Net::OpenTimeout) do
      pop.start("account", "secret")
    end
  end

  def test_read
    pop = Net::POP.new(read_host, read_port)
    pop.read_timeout = 1
    assert_timeout(Net::ReadTimeout) do
      pop.start("account", "secret")
    end
  end
end
