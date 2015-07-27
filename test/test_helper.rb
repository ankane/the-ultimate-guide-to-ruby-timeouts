require "bundler/setup"
Bundler.require :default
require "minitest/autorun"
require "minitest/pride"

class UnknownTimeoutError < StandardError; end

class Minitest::Test
  def assert_timeout(exception = UnknownTimeoutError, options = {})
    timeout = options[:timeout] || 1
    started_at = Time.now
    begin
      assert_raises(exception) { yield }
    ensure
      time = Time.now - started_at
      p time
      assert time > timeout && time < timeout + 2, "Took #{time} seconds to timeout"
    end
  end

  def connect_host
    "10.255.255.1"
  end

  def connect_url
    "http://#{connect_host}"
  end

  def read_host
    "localhost"
  end

  def read_port
    4567
  end

  def read_host_and_port
    "#{read_host}:#{read_port}"
  end

  def read_url
    "http://#{read_host_and_port}"
  end
end
