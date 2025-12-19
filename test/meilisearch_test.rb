require_relative "test_helper"

class MeilisearchTest < Minitest::Test
  def test_connect
    client = Meilisearch::Client.new(connect_url, "key", timeout: 1, max_retries: 0)
    assert_timeout(Meilisearch::TimeoutError) do
      client.index("books").search("test")
    end
  end

  def test_read
    client = Meilisearch::Client.new(read_url, "key", timeout: 1)
    assert_timeout(Meilisearch::TimeoutError) do
      client.index("books").search("test")
    end
  end
end
