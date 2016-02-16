require_relative "test_helper"

class BunnyTest < Minitest::Test
  def test_connect
    assert_timeout(Bunny::TCPConnectionFailedForAllHosts) do
      Bunny.new(host: connect_host, connection_timeout: 1).start
    end
  end

  def test_read
    assert_timeout(Bunny::NetworkFailure) do
      Bunny.new(host: read_host, port: read_port, read_timeout: 1, automatically_recover: false).start
    end
  end
end
