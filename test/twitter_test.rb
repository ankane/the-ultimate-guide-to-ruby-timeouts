require_relative "test_helper"

class TwitterTest < Minitest::Test
  def test_connect
    skip
    Twitter::REST::Client.send(:remove_const, "BASE_URL")
    Twitter::REST::Client.const_set("BASE_URL", connect_url)
    Twitter::REST::Client.new(timeouts: {connect: 1}).followers
  end
end
