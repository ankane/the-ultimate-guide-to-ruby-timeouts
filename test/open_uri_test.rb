require_relative "test_helper"
require "open-uri"

class OpenUriTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      open(connect_url, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      open(read_url, read_timeout: 1)
    end
  end
end
