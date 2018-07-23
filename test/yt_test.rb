require_relative "test_helper"

Yt.configure do |config|
  config.log_level = :debug
end

class YtTest < Minitest::Test
  def test_connect
    skip # unable to set host

    video = Yt::Video.new(id: "test")
    assert_timeout(Net::OpenTimeout) do
      video.title
    end
  end
end
