require_relative "test_helper"

class TwilioTest < Minitest::Test
  def test_connect
    http_client = Twilio::HTTP::Client.new(connect_host, 80, "http://user", "secret", timeout: 1)
    assert_timeout(Faraday::ConnectionFailed) do
      Twilio::REST::Client.new("sid", "token", nil, nil, http_client).api.account.calls.list
    end
  end

  def test_read
    http_client = Twilio::HTTP::Client.new(read_host, read_port, "http://user", "secret", timeout: 1)
    assert_timeout(Faraday::TimeoutError) do
      Twilio::REST::Client.new("sid", "token", nil, nil, http_client).api.account.calls.list
    end
  end
end
