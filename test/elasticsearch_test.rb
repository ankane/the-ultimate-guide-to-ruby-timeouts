require_relative "test_helper"

class ElasticsearchTest < Minitest::Test
  def test_connect
    assert_timeout(Faraday::ConnectionFailed) { Elasticsearch::Client.new(adapter: :net_http, host: connect_host, log: true, transport_options: {request: {timeout: 1}}).cluster.health }
  end

  def test_read
    assert_timeout(Faraday::TimeoutError) { Elasticsearch::Client.new(adapter: :net_http, host: read_host_and_port, log: true, transport_options: {request: {timeout: 1}}).cluster.health }
  end
end
