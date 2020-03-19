require_relative "test_helper"

class TwilioTest < Minitest::Test
  def test_connect
    http_client = Twilio::HTTP::Client.new("http", connect_host, 80, timeout: 1)
    assert_timeout(Twilio::REST::TwilioError) do
      Twilio::REST::Client.new("sid", "token", nil, nil, http_client).api.account.calls.list
    end
  end

  def test_read
    http_client = Twilio::HTTP::Client.new("http", read_host, read_port, timeout: 1)
    assert_timeout(Twilio::REST::TwilioError) do
      Twilio::REST::Client.new("sid", "token", nil, nil, http_client).api.account.calls.list
    end
  end
end
