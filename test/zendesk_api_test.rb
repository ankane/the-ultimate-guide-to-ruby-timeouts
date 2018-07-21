require_relative "test_helper"

class ZendeskApiTest < Minitest::Test
  def test_connect
    client = ZendeskAPI::Client.new do |config|
      config.url = connect_url
      config.allow_http = true
      config.client_options = {request: {open_timeout: 1}}
    end

    assert_timeout(ZendeskAPI::Error::NetworkError) do
      client.tickets.find!(id: 1)
    end
  end

  def test_read
    client = ZendeskAPI::Client.new do |config|
      config.url = read_url
      config.allow_http = true
      config.client_options = {request: {timeout: 1}}
    end

    assert_timeout(ZendeskAPI::Error::NetworkError) do
      client.tickets.find!(id: 1)
    end
  end
end
