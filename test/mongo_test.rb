require_relative "test_helper"

class MongoTest < Minitest::Test
  def test_connect
    assert_timeout(Mongo::Error::NoServerAvailable) do
      Mongo::Client.new([connect_host], socket_timeout: 1, server_selection_timeout: 1)[:artists].find.count
    end
  end
end
