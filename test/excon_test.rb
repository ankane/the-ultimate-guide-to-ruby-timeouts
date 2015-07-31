require_relative "test_helper"

class ExconTest < Minitest::Test
  def test_connect
    assert_timeout(Excon::Errors::Timeout) do
      Excon.get(connect_url, connect_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Excon::Errors::Timeout) do
      Excon.get(read_url, read_timeout: 1)
    end
  end
end
