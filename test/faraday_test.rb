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

  def test_connect_new
    assert_timeout(Faraday::ConnectionFailed) do
      Faraday.new(connect_url, request: {open_timeout: 1, timeout: 1}).get("/")
    end
  end

  def test_read_new
    assert_timeout(Faraday::TimeoutError) do
      Faraday.new(read_url, request: {open_timeout: 1, timeout: 1}).get("/")
    end
  end
end
