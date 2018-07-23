require_relative "test_helper"

class InfluxDBTest < Minitest::Test
  def test_connect
    assert_timeout(InfluxDB::ConnectionError) do
      InfluxDB::Client.new(url: connect_url, open_timeout: 1, retry: 0).write_point("name", {})
    end
  end

  def test_read
    assert_timeout(InfluxDB::ConnectionError) do
      InfluxDB::Client.new(url: read_url, read_timeout: 1, retry: 0).write_point("name", {})
    end
  end
end
