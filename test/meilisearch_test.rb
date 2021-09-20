require_relative "test_helper"

class MeilisearchTest < Minitest::Test
  def test_connect
    client = MeiliSearch::Client.new(connect_url, "key", timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.index("books").search("test")
    end
  end

  def test_read
    client = MeiliSearch::Client.new(read_url, "key", timeout: 1)
    assert_timeout(Net::ReadTimeout) do
      client.index("books").search("test")
    end
  end
end
