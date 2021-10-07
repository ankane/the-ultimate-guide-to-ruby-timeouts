require_relative "test_helper"
require "net/http"
require "open-uri"

class OpenUriTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      URI.open(connect_url, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      URI.open(read_url, read_timeout: 1)
    end
  end
end
