require_relative "test_helper"
require "google/cloud/storage"

class GoogleCloudTest < Minitest::Test
  def setup
    skip if ENV["TRAVIS"]
  end

  def test_connect
    assert_timeout(Google::Cloud::Error) do
      storage = Google::Cloud::Storage.new(project: "test", timeout: 1, retries: 0)
      storage.service.service.root_url = connect_url + "/"
      storage.buckets
    end
  end

  def test_read
    assert_timeout(Google::Cloud::Error) do
      storage = Google::Cloud::Storage.new(project: "test", timeout: 1, retries: 0)
      storage.service.service.root_url = read_url + "/"
      storage.buckets
    end
  end
end
