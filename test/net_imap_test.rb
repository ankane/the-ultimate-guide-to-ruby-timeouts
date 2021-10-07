require_relative "test_helper"
require "net/imap"

class NetImapTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      Net::IMAP.new(connect_host, open_timeout: 1)
    end
  end

  def test_read
    skip "Not configurable"

    assert_timeout(Net::ReadTimeout) do
      Net::IMAP.new(read_host, port: read_port)
    end
  end
end
