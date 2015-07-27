require_relative "test_helper"

class HttpartyTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      HTTParty.get(connect_url, timeout: 1)
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      HTTParty.get(read_url, timeout: 1)
    end
  end
end
