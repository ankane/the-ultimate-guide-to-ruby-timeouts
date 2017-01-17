require_relative "test_helper"

class RsolrTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      RSolr.connect(url: connect_url, open_timeout: 1).get("select")
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      RSolr.connect(url: read_url, read_timeout: 1).get("select")
    end
  end
end
