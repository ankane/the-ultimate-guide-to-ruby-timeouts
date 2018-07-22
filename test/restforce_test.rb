require_relative "test_helper"

class RestforceTest < Minitest::Test
  def test_connect
    assert_timeout(Faraday::ConnectionFailed) do
      Restforce.new(instance_url: connect_url, timeout: 1).describe
    end
  end

  def test_read
    assert_timeout(Faraday::TimeoutError) do
      Restforce.new(instance_url: read_url, timeout: 1).describe
    end
  end
end
