require_relative "test_helper"

class KoalaTest < Minitest::Test
  def test_connect
    Koala.configure do |config|
      config.graph_server = connect_host
    end
    Koala.http_service.http_options = {request: {open_timeout: 1}}
    assert_timeout(Faraday::ConnectionFailed) do
      Koala::Facebook::API.new.get_object("me")
    end
  end

  def test_read
    Koala.configure do |config|
      config.graph_server = read_host_and_port
    end
    Koala.http_service.http_options = {request: {timeout: 1}}
    assert_timeout(Faraday::ConnectionFailed) do
      Koala::Facebook::API.new.get_object("me")
    end
  end
end
