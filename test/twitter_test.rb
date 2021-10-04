require_relative "test_helper"

class TwitterTest < Minitest::Test
  def test_connect
    assert_raises(HTTP::TimeoutError) do
      Twitter::REST::Request.send(:remove_const, "BASE_URL")
      Twitter::REST::Request.const_set("BASE_URL", connect_url)
      client = Twitter::REST::Client.new do |config|
        # must all be set
        config.timeouts = {connect: 1, read: 30, write: 30}
      end
      client.followers
    end
  end

  def test_read
    assert_raises(HTTP::TimeoutError) do
      Twitter::REST::Request.send(:remove_const, "BASE_URL")
      Twitter::REST::Request.const_set("BASE_URL", read_url)
      client = Twitter::REST::Client.new do |config|
        # must all be set
        config.timeouts = {connect: 30, read: 1, write: 30}
      end
      client.followers
    end
  end
end
