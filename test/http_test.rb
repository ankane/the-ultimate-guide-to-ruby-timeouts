require_relative "test_helper"

class HttpTest < Minitest::Test
  def test_connect
    assert_timeout(HTTP::TimeoutError) do
      HTTP.timeout(connect: 1).get(connect_url)
    end
  end

  def test_read
    assert_timeout(HTTP::TimeoutError) do
      HTTP.timeout(read: 1).get(read_url)
    end
  end
end
