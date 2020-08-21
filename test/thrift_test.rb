require_relative "test_helper"

class RbhiveTest < Minitest::Test
  def test_connect
    socket = Thrift::Socket.new(connect_host, 9090, 1)
    assert_timeout(Thrift::TransportException) do
      socket.open
    end
  end

  def test_read
    socket = Thrift::Socket.new(read_host, read_port, 1)
    socket.open
    assert_timeout(Thrift::TransportException) do
      socket.read(1)
    end
  end
end
