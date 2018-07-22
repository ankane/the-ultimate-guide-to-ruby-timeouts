require_relative "test_helper"

class StatsdTest < Minitest::Test
  def test_connect
    # no need to set timeouts
    statsd = Statsd.new(connect_host, 9125)
    statsd.increment("counter")
  end

  def test_read
    # no need to set timeouts
    statsd = Statsd.new(read_host, read_port)
    statsd.increment("counter")
  end
end
