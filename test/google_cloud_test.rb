require_relative "test_helper"
require "google/cloud/storage"

class GoogleCloudTest < Minitest::Test
  def setup
    skip if travis?
  end

  def test_connect
    storage = Google::Cloud::Storage.new(project: "test", timeout: 1, retries: 0)
    storage.service.service.root_url = connect_url + "/"

    assert_timeout(Google::Cloud::Error) do
      storage.buckets
    end
  end

  def test_read
    storage = Google::Cloud::Storage.new(project: "test", timeout: 1, retries: 0)
    storage.service.service.root_url = read_url + "/"

    assert_timeout(Google::Cloud::Error) do
      storage.buckets
    end
  end
end
