require_relative "test_helper"

class DropletKitTest < Minitest::Test
  def test_connect
    assert_timeout(Faraday::ConnectionFailed) do
      DropletKit::Client.new(api_url: connect_url, open_timeout: 1).droplets.find(id: "id")
    end
  end

  def test_read
    assert_timeout(Faraday::TimeoutError) do
      DropletKit::Client.new(api_url: read_url, timeout: 1).droplets.find(id: "id")
    end
  end
end
