require_relative "test_helper"

class StompTest < Minitest::Test
  def test_connect
    assert_timeout(Stomp::Error::StartTimeoutException) do
      Stomp::Client.new(hosts: [{host: connect_host, port: 61612}], reliable: false, start_timeout: 1)
    end
  end

  def test_read
    # unable to test beyond start
    assert_timeout(Stomp::Error::StartTimeoutException) do
      Stomp::Client.new(hosts: [{host: read_host, port: read_port}], reliable: false, start_timeout: 1)
    end
  end
end
