require_relative "test_helper"

Aws.config.update(
  region: "us-east-1",
  credentials: Aws::Credentials.new("akid", "secret"),
  retry_limit: 0
)

class AwsSdkTest < Minitest::Test
  def test_connect
    Aws.config.update(endpoint: connect_url, http_open_timeout: 1)
    assert_timeout(Seahorse::Client::NetworkingError) do
      Aws::S3::Client.new.list_buckets
    end
  end

  def test_read
    Aws.config.update(endpoint: read_url, http_read_timeout: 1)
    assert_timeout(Seahorse::Client::NetworkingError) do
      Aws::S3::Client.new.list_buckets
    end
  end
end
