require_relative "test_helper"

class UnirestTest < Minitest::Test
  def setup
    skip # requires Ruby < 3
  end

  def test_connect
    skip # not configurable

    Unirest.timeout(1)
    assert_timeout(RuntimeError) do
      Unirest.get(connect_url)
    end
  end

  def test_read
    Unirest.timeout(1)
    assert_timeout(RuntimeError) do
      Unirest.get(read_url)
    end
  end
end
