require_relative "test_helper"

class GraphqlClientTest < Minitest::Test
  def test_connect
    http = GraphQL::Client::HTTP.new(connect_url) do
      def connection
        conn = super
        conn.open_timeout = 1
        conn
      end
    end

    assert_timeout(Net::OpenTimeout) do
      GraphQL::Client.load_schema(http)
    end
  end

  def test_read
    http = GraphQL::Client::HTTP.new(read_url) do
      def connection
        conn = super
        conn.read_timeout = 1
        conn
      end
    end

    assert_timeout(Net::ReadTimeout) do
      GraphQL::Client.load_schema(http)
    end
  end
end
