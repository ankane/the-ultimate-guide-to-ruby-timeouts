require "bundler/setup"
Bundler.require :default
require "minitest/autorun"
require "minitest/pride"

class UnknownTimeoutError < StandardError; end

class Minitest::Test
  def assert_timeout(exception = UnknownTimeoutError)
    started_at = Time.now
    begin
      assert_raises(exception) { yield }
    ensure
      time = Time.now - started_at
      p time
      assert time < 3, "Took #{time} seconds to timeout"
    end
  end

  def connect_host
    "10.255.255.1"
  end

  def connect_url
    "http://#{connect_host}"
  end
end
