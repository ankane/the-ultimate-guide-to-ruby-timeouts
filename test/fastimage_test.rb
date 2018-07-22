require_relative "test_helper"

class FastImageTest < Minitest::Test
  def test_connect
    assert_nil FastImage.size(connect_url, timeout: 1)
  end

  def test_connect_raise
    assert_raises(FastImage::ImageFetchFailure) do
      FastImage.size(connect_url, timeout: 1, raise_on_failure: true)
    end
  end

  def test_read
    assert_nil FastImage.size(read_url, timeout: 1)
  end

  def test_read_raise
    assert_raises(FastImage::ImageFetchFailure) do
      FastImage.size(read_url, timeout: 1, raise_on_failure: true)
    end
  end
end
