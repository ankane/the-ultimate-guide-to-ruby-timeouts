require_relative "test_helper"

class AlgoliasearchTest < Minitest::Test
  def test_connect
    Algolia.init(application_id: "id", hosts: [connect_host], connect_timeout: 1)

    assert_timeout(Algolia::AlgoliaProtocolError) do
      Algolia::Index.new("index").search("hi")
    end
  end

  def test_read
    Algolia.init(application_id: "id", hosts: [read_host_and_port], receive_timeout: 1)

    assert_timeout(Algolia::AlgoliaProtocolError, timeout: 2) do
      Algolia::Index.new("index").search("hi")
    end
  end
end
