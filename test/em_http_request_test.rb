require_relative "test_helper"

class EmHttpRequestClientTest < Minitest::Test
  def test_connect
    assert_timeout(Errno::ETIMEDOUT) do
      EventMachine.run do
        http = EventMachine::HttpRequest.new(connect_url, connect_timeout: 1).get
        http.errback  { raise http.error }
      end
    end
  end

  def test_read
    assert_timeout(Errno::ETIMEDOUT) do
      EventMachine.run do
        http = EventMachine::HttpRequest.new(read_url, inactivity_timeout: 1).get
        http.errback  { raise http.error }
      end
    end
  end
end
