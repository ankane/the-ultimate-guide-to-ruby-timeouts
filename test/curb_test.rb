require_relative "test_helper"

class CurbTest < Minitest::Test
  def test_connect
    skip
    assert_timeout(Curl::Err::TimeoutError, timeout: timeout) do
      curl = Curl::Easy.new(connect_url)
      curl.connect_timeout = 1
      curl.perform
    end
  end

  def test_connect_timeout_option
    assert_timeout(Curl::Err::TimeoutError, timeout: timeout) do
      curl = Curl::Easy.new(connect_url)
      curl.timeout = 1
      curl.perform
    end
  end

  def test_read
    assert_timeout(Curl::Err::TimeoutError, timeout: timeout) do
      curl = Curl::Easy.new(read_url)
      curl.timeout = 1
      curl.perform
    end
  end

  def timeout
    # times out early
    0.99
  end
end
