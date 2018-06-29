require_relative "test_helper"

class MongoTest < Minitest::Test
  def test_connect
    assert_timeout(Mongo::Error::NoServerAvailable, timeout: 3) do
      Mongo::Client.new([connect_host], connect_timeout: 1, socket_timeout: 1, server_selection_timeout: 1)[:artists].find.count
    end
  end

  def test_read
    assert_timeout(Mongo::Error::NoServerAvailable, timeout: 3) do
      Mongo::Client.new([read_host_and_port], connect_timeout: 1, socket_timeout: 1, server_selection_timeout: 1)[:artists].find.count
    end
  end
end
