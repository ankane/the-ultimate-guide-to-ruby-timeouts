require_relative "test_helper"
require "typhoeus/adapters/faraday"

class SearchkickTest < Minitest::Test
  def setup
    Searchkick.timeout = 1
    Searchkick.client_options = {retry_on_failure: false}
    Searchkick.client = nil
  end

  def test_connect
    ENV["ELASTICSEARCH_URL"] = connect_url
    assert_timeout(Faraday::ConnectionFailed) do
      Searchkick.client.cluster.health
    end
  end

  def test_read
    ENV["ELASTICSEARCH_URL"] = read_url
    assert_timeout(Faraday::TimeoutError) do
      Searchkick.client.cluster.health
    end
  end
end
