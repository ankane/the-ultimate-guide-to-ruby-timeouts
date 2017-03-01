require_relative "test_helper"

class AwsSdkTest < Minitest::Test
  def test_connect
    Aws.config = {endpoint: connect_url, retry_limit: 0, http_open_timeout: 1}
    assert_timeout(Seahorse::Client::NetworkingError) do
      Aws::S3::Client.new.list_buckets
    end
  end

  def test_read
    Aws.config = {endpoint: read_url, retry_limit: 0, http_read_timeout: 1}
    assert_timeout(Seahorse::Client::NetworkingError) do
      Aws::S3::Client.new.list_buckets
    end
  end
end
