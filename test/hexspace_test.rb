require_relative "test_helper"

class HexspaceTest < Minitest::Test
  def test_connect
    assert_timeout(Thrift::TransportException) do
      Hexspace::Client.new(host: connect_host, mode: :nosasl, timeout: 1)
    end
  end

  def test_read
    assert_timeout(Thrift::TransportException) do
      Hexspace::Client.new(host: read_host, port: read_port, mode: :nosasl, timeout: 1)
    end
  end
end
