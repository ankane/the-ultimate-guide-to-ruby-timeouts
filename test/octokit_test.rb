require_relative "test_helper"

class OctokitTest < Minitest::Test
  def test_connect
    client = Octokit::Client.new(api_endpoint: connect_url, connection_options: {request: {open_timeout: 1}})
    assert_timeout(Faraday::ConnectionFailed) do
      client.user
    end
  end

  def test_read
    client = Octokit::Client.new(api_endpoint: read_url, connection_options: {request: {timeout: 1}})
    assert_timeout(Faraday::TimeoutError) do
      client.user
    end
  end
end
