require_relative "test_helper"
require "google/apis/drive_v2"

class GoogleApiClientTest < Minitest::Test
  def setup
  end

  def test_connect
    client = Google::Apis::DriveV2::DriveService.new
    client.client_options.open_timeout_sec = 1
    client.root_url = connect_url + "/"

    assert_timeout(Google::Apis::TransmissionError) do
      client.list_files
    end
  end

  def test_read
    client = Google::Apis::DriveV2::DriveService.new
    client.client_options.read_timeout_sec = 1
    client.root_url = read_url + "/"

    assert_timeout(Google::Apis::TransmissionError) do
      client.list_files
    end
  end
end
