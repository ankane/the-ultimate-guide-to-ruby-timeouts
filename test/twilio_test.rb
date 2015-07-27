require_relative "test_helper"

class TwilioTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Twilio::REST::Client.new("sid", "token", host: connect_host, timeout: 1).calls.list
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      Twilio::REST::Client.new("sid", "token", host: read_host, port: read_port, use_ssl: false, timeout: 1).calls.list
    end
  end
end
