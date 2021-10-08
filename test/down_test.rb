require_relative "test_helper"

class DownTest < Minitest::Test
  def test_connect
    assert_timeout(Down::TimeoutError) do
      Down::NetHttp.download(connect_url, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Down::TimeoutError, timeout: 2) do
      Down::NetHttp.download(read_url, read_timeout: 1)
    end
  end
end
