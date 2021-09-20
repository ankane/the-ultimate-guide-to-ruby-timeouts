require_relative "test_helper"

class PusherTest < Minitest::Test
  def test_connect
    client = Pusher::Client.new(host: connect_host, app_id: "test", key: "test", secret: "test")
    client.connect_timeout = 1
    assert_timeout(Pusher::HTTPError) do
      client.trigger("channel", "event", {})
    end
  end

  def test_read
    client = Pusher::Client.new(host: read_host, port: read_port, app_id: "test", key: "test", secret: "test", use_tls: false)
    client.receive_timeout = 1
    assert_timeout(Pusher::HTTPError) do
      client.trigger("channel", "event", {})
    end
  end
end
