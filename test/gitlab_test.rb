require_relative "test_helper"

class GitlabTest < Minitest::Test
  def test_connect
    client =
      Gitlab.client(
        endpoint: connect_url,
        private_token: "test",
        httparty: {
          timeout: 1
        }
      )

    assert_timeout(Net::OpenTimeout) do
      client.user
    end
  end

  def test_read
    client =
      Gitlab.client(
        endpoint: read_url,
        private_token: "test",
        httparty: {
          timeout: 1
        }
      )

    assert_timeout(Net::ReadTimeout) do
      client.user
    end
  end
end
