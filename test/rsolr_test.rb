require_relative "test_helper"

class RsolrTest < Minitest::Test
  def test_connect
    assert_timeout(RSolr::Error::ConnectionRefused) do
      RSolr.connect(url: connect_url, open_timeout: 1).get("select")
    end
  end

  def test_read
    assert_timeout(RSolr::Error::Http) do
      RSolr.connect(url: read_url, read_timeout: 1).get("select")
    end
  end
end
