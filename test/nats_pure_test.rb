require_relative "test_helper"
require "nats/io/client"

class NatsPureTest < Minitest::Test
  def test_connect
    nats = NATS::IO::Client.new

    assert_timeout(NATS::IO::SocketTimeoutError, timeout: 2) do
      nats.connect(
        servers: ["nats://#{connect_host}:4222"],
        connect_timeout: 1,
        max_reconnect_attempts: 0,
        reconnect_time_wait: 0
      )
    end
  end

  def test_read
    nats = NATS::IO::Client.new

    assert_timeout(NATS::IO::SocketTimeoutError) do
      nats.connect(
        servers: ["nats://#{read_host_and_port}"],
        connect_timeout: 1,
        max_reconnect_attempts: 0,
        reconnect_time_wait: 0
      )
    end
  end
end
