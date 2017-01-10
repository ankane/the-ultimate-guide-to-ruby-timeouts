require_relative "test_helper"

class TwitterTest < Minitest::Test
  def test_connect
    assert_raises(HTTP::TimeoutError) do
      Twitter::REST::Request.send(:remove_const, "BASE_URL")
      Twitter::REST::Request.const_set("BASE_URL", connect_url)
      Twitter::REST::Client.new(timeouts: {connect: 1}).followers
    end
  end

  def test_read
    assert_raises(HTTP::TimeoutError) do
      Twitter::REST::Request.send(:remove_const, "BASE_URL")
      Twitter::REST::Request.const_set("BASE_URL", read_url)
      Twitter::REST::Client.new(timeouts: {read: 1}).followers
    end
  end
end
