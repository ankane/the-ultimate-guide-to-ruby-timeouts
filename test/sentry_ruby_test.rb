require_relative "test_helper"

class SentryRubyTest < Minitest::Test
  def test_connect
    Sentry.init do |config|
      config.dsn = "http://key@#{connect_host}/1"
      config.transport.open_timeout = 1
    end
    client = Sentry::Client.new(Sentry.configuration)
    assert_timeout(Sentry::ExternalError) do
      client.transport.send_event(client.event_from_message("Test"))
    end
  end

  def test_read
    Sentry.init do |config|
      config.dsn = "http://key@#{read_host_and_port}/1"
      config.transport.timeout = 1
    end
    client = Sentry::Client.new(Sentry.configuration)
    assert_timeout(Sentry::ExternalError) do
      client.transport.send_event(client.event_from_message("Test"))
    end
  end
end
