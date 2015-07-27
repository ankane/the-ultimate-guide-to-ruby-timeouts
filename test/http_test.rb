require_relative "test_helper"

class HttpTest < Minitest::Test
  def test_connect
    assert_timeout(HTTP::TimeoutError) { HTTP.timeout(:per_operation, connect: 1).get(connect_url) }
  end
end
