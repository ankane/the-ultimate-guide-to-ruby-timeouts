require_relative "test_helper"

class CurbTest < Minitest::Test
  def test_connect
    assert_timeout(Curl::Err::TimeoutError) do
      curl = Curl::Easy.new(connect_url)
      curl.connect_timeout = 1
      curl.perform
    end
  end

  # def test_connect_default
  #   Curl::Multi.default_timeout = 1
  #   assert_timeout() { Curl::Multi.get([connect_url]) }
  # end
end
