require_relative "test_helper"

class BunnyTest < Minitest::Test
  def test_connect
    assert_timeout(Bunny::TCPConnectionFailedForAllHosts) do
      Bunny.new(host: connect_host, connection_timeout: 1).start
    end
  end
end
