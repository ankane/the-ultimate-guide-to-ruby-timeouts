require "bundler/setup"
Bundler.require :default
require "minitest/autorun"
require "minitest/pride"

class UnknownTimeoutError < StandardError; end

class Minitest::Test
  def assert_timeout(exception = UnknownTimeoutError, timeout: nil)
    started_at = Time.now
    assert_raises(exception) { yield }
    time = Time.now - started_at
    # p time
    assert_operator time, :>=, timeout
    assert_operator time, :<=, timeout + 2
  end

  def assert_threaded_timeout(exception = UnknownTimeoutError, timeout: nil)
    Thread.abort_on_exception = true
    threads = []
    2.times do |i|
      threads << Thread.new { yield }
    end
    assert_timeout(exception, options) do
      threads.each(&:join)
    end
  end

  def connect_host
    "10.255.255.1"
  end

  def connect_url
    "http://#{connect_host}"
  end

  def read_host
    "127.0.0.1"
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
