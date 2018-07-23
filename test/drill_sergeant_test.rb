require_relative "test_helper"

class DrillSergeantTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Drill.new(url: connect_url, open_timeout: 1).query("hi")
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      Drill.new(url: read_url, read_timeout: 1).query("hi")
    end
  end
end
