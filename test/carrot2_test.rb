require_relative "test_helper"

class Carrot2Test < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Carrot2.new(url: connect_url, open_timeout: 1).cluster([])
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      Carrot2.new(url: read_url, read_timeout: 1).cluster([])
    end
  end
end
