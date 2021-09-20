require_relative "test_helper"

class SlackRubyClientTest < Minitest::Test
  def test_connect
    client = Slack::Web::Client.new(endpoint: connect_url, open_timeout: 1)
    assert_timeout(Slack::Web::Api::Errors::TimeoutError) do
      client.auth_test
    end
  end

  def test_read
    client = Slack::Web::Client.new(endpoint: read_url, timeout: 1)
    assert_timeout(Slack::Web::Api::Errors::TimeoutError) do
      client.auth_test
    end
  end
end
