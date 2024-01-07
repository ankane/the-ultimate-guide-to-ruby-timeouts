require_relative "test_helper"

class ElasticsearchTest < Minitest::Test
  def test_connect
    assert_timeout(Elastic::Transport::Transport::Error) do
      Elasticsearch::Client.new(adapter: :net_http, host: connect_host, transport_options: {request: {timeout: 1}}).cluster.health
    end
  end

  def test_read
    assert_timeout(Elastic::Transport::Transport::Error) do
      Elasticsearch::Client.new(adapter: :net_http, host: read_host_and_port, transport_options: {request: {timeout: 1}}).cluster.health
    end
  end
end
