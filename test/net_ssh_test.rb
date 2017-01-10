require_relative "test_helper"
require "net/ssh"

class NetSSHTest < Minitest::Test
  def test_connect
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SSH.start(connect_host, nil, timeout: 1) do |ssh|
        ssh.exec!("hostname")
      end
    end
  end

  def test_read
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SSH.start(read_host, nil, port: read_port, timeout: 1) do |ssh|
        ssh.exec!("hostname")
      end
    end
  end
end
