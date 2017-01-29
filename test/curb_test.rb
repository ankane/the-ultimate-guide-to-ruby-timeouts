require_relative "test_helper"

class CurbTest < Minitest::Test
  def test_connect
    # times out early on Travis
    assert_timeout(Curl::Err::TimeoutError, timeout: 0.99) do
      curl = Curl::Easy.new(connect_url)
      curl.connect_timeout = 1
      curl.perform
    end
  end

  def test_connect_timeout_option
    # times out early on Travis
    assert_timeout(Curl::Err::TimeoutError, timeout: 0.99) do
      curl = Curl::Easy.new(connect_url)
      curl.timeout = 1
      curl.perform
    end
  end

  def test_read
    # times out early on Travis
    assert_timeout(Curl::Err::TimeoutError, timeout: 0.99) do
      curl = Curl::Easy.new(read_url)
      curl.timeout = 1
      curl.perform
    end
  end
end
