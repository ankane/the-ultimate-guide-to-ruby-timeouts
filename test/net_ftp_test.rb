require_relative "test_helper"
require "net/ftp"

class NetFtpTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Net::FTP.new(connect_host, open_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout) do
      Net::FTP.new(read_host, port: read_port, read_timeout: 1)
    end
  end
end
