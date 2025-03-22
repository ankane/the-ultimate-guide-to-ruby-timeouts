require_relative "test_helper"

class SentryRubyTest < Minitest::Test
  def test_connect
    Sentry.init do |config|
      config.dsn = connect_url
      config.transport.open_timeout = 1
    end
    assert_timeout(Sentry::ExternalError) do
      Sentry::Client.new(Sentry.configuration).transport.send_event({})
    end
  end

  def test_read
    Sentry.init do |config|
      config.dsn = read_url
      config.transport.timeout = 1
    end
    assert_timeout(Sentry::ExternalError) do
      Sentry::Client.new(Sentry.configuration).transport.send_event({})
    end
  end
end
