require_relative "test_helper"

class FirebaseTest < Minitest::Test
  def test_connect
    assert_timeout(HTTPClient::ConnectTimeoutError) do
      firebase = Firebase::Client.new(connect_url.sub("http", "https"))
      firebase.request.instance_variable_get(:@client).connect_timeout = 1
      firebase.get("boom")
    end
  end
end
