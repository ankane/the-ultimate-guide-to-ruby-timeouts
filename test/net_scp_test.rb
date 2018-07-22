require_relative "test_helper"
require "net/scp"

class NetSSHTest < Minitest::Test
  def test_connect
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SCP.start(connect_host, nil, timeout: 1) do |scp|
        scp.download!("/local/path", "/remote/path")
      end
    end
  end

  def test_read
    assert_timeout(Net::SSH::ConnectionTimeout) do
      Net::SCP.start(read_host, nil, port: read_port, timeout: 1) do |scp|
        scp.download!("/local/path", "/remote/path")
      end
    end
  end
end
