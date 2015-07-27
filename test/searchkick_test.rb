require_relative "test_helper"
require "typhoeus/adapters/faraday"

class SearchkickTest < Minitest::Test
  def test_connect
    ENV["ELASTICSEARCH_URL"] = connect_url
    Searchkick.timeout = 1
    assert_timeout(Faraday::TimeoutError) { Searchkick.client.cluster.health }
  end
end
