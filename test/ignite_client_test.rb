require_relative "test_helper"

class IgniteClientTest < Minitest::Test
  def test_connect
    assert_timeout(Ignite::TimeoutError) do
      Ignite::Client.new(host: connect_host, connect_timeout: 1)
    end
  end
end
