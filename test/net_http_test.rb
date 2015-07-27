require_relative "test_helper"
require "net/http"

class NetHttpTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) { Net::HTTP.start(connect_host, 80, open_timeout: 1) { } }
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      Net::HTTP.start(read_host, read_port, read_timeout: 1) do |http|
        response = http.head("/")
      end
    end
  end
end
