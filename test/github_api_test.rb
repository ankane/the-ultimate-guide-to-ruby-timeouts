require_relative "test_helper"

class GithubApiTest < Minitest::Test
  def test_connect
    github = Github.new(endpoint: connect_url, connection_options: {request: {open_timeout: 1}})
    assert_timeout(Faraday::ConnectionFailed) do
      github.repos.list(user: "ankane")
    end
  end

  def test_read
    github = Github.new(endpoint: read_url, connection_options: {request: {timeout: 1}})
    assert_timeout(Faraday::TimeoutError) do
      github.repos.list(user: "ankane")
    end
  end
end
