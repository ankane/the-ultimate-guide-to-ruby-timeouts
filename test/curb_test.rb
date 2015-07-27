require_relative "test_helper"

class CurbTest < Minitest::Test
  def test_connect
    assert_timeout(Curl::Err::TimeoutError) do
      curl = Curl::Easy.new(connect_url)
      curl.connect_timeout = 1
      curl.perform
    end

    assert_timeout(Curl::Err::TimeoutError) do
      curl = Curl::Easy.new(connect_url)
      curl.timeout = 1
      curl.perform
    end
  end

  def test_read
    assert_timeout(Curl::Err::TimeoutError) do
      curl = Curl::Easy.new(read_url)
      curl.timeout = 1
      curl.perform
    end
  end
end
