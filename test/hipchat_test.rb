require_relative "test_helper"

class HipchatTest < Minitest::Test
  def setup
    [HipChat::Client, HipChat::Room, HipChat::User].each { |c| c.default_timeout(1) }
  end

  def test_connect
    assert_timeout(Net::OpenTimeout) do
      HipChat::Client.new("api_token", server_url: connect_url)["room"].history
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      HipChat::Client.new("api_token", server_url: read_url)["room"].history
    end
  end
end
