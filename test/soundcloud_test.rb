require_relative "test_helper"

class SoundCloudTest < Minitest::Test
  def test_connect
    skip "Not configurable yet"

    client = SoundCloud.new(client_id: "id", timeout: 1)
    api_host = connect_host
    client.define_singleton_method(:api_host, -> { api_host })

    assert_timeout(Net::OpenTimeout) do
      client.get("/tracks")
    end
  end

  def test_read
    skip "Not configurable yet"

    client = SoundCloud.new(client_id: "id", timeout: 1)
    api_host = read_host_and_port
    client.define_singleton_method(:api_host, -> { api_host })

    assert_timeout(Net::ReadTimeout) do
      client.get("/tracks")
    end
  end
end
