require_relative "test_helper"

class FaradayTest < Minitest::Test
  def test_connect
    assert_timeout(Faraday::ConnectionFailed) do
      Faraday.get(connect_url) do |req|
        req.options.open_timeout = 1
      end
    end
  end

  def test_read
    assert_timeout(Faraday::TimeoutError) do
      Faraday.get(read_url) do |req|
        req.options.timeout = 1
      end
    end
  end
end
