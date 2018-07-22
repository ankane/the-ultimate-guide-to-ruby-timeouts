require_relative "test_helper"
require "net/sftp"

class NetSftpTest < Minitest::Test
  def test_connect
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SFTP.start(connect_host, nil, timeout: 1) do |sftp|
        sftp.download!("/local/path", "/remote/path")
      end
    end
  end

  def test_read
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SFTP.start(read_host, nil, port: read_port, timeout: 1) do |sftp|
        sftp.download!("/local/path", "/remote/path")
      end
    end
  end
end
