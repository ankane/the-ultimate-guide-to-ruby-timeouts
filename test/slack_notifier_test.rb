require_relative "test_helper"

class SlackNotifierTest < Minitest::Test
  def test_connect
    notifier = Slack::Notifier.new(connect_url, http_options: {open_timeout: 1})
    assert_timeout(Net::OpenTimeout) do
      notifier.ping "Hello World"
    end
  end

  def test_read
    notifier = Slack::Notifier.new(read_url, http_options: {read_timeout: 1})
    assert_timeout(Net::ReadTimeout) do
      notifier.ping "Hello World"
    end
  end
end
