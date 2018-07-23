require_relative "test_helper"

class SocketTest < Minitest::Test
  def test_connect
    assert_timeout(Errno::ETIMEDOUT) do
      Socket.tcp(connect_host, 80, connect_timeout: 1) do |sock|
        sock.print "GET / HTTP/1.0\r\nHost: www.ruby-lang.org\r\n\r\n"
        sock.close_write
        puts sock.read
      end
    end
  end
end
