require_relative "test_helper"

class PinterestApiTest < Minitest::Test
  def test_connect
    Pinterest::Client.send(:remove_const, "BASE_ENDPOINT")
    Pinterest::Client.const_set("BASE_ENDPOINT", "#{connect_url}/")

    assert_timeout(Faraday::ConnectionFailed) do
      Pinterest::Client.new("token", request: {open_timeout: 1}).me
    end
  end

  def test_read
    Pinterest::Client.send(:remove_const, "BASE_ENDPOINT")
    Pinterest::Client.const_set("BASE_ENDPOINT", "#{read_url}/")

    assert_timeout(Faraday::TimeoutError) do
      Pinterest::Client.new("token", request: {timeout: 1}).me
    end
  end
end
