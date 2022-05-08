require_relative "test_helper"

class InfluxdbClientTest < Minitest::Test
  def test_connect
    client = InfluxDB2::Client.new(connect_url, "token", open_timeout: 1, org: "org")
    assert_timeout(InfluxDB2::InfluxError) do
      client.create_query_api.query(query: "from")
    end
  end

  def test_read
    client = InfluxDB2::Client.new(read_url, "token", read_timeout: 1, org: "org", use_ssl: false)
    assert_timeout(InfluxDB2::InfluxError) do
      client.create_query_api.query(query: "from")
    end
  end
end
