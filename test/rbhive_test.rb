require_relative "test_helper"

class RbhiveTest < Minitest::Test
  def test_connect
    assert_timeout(Thrift::TransportException) do
      RBHive.tcli_connect(connect_host, 10000, timeout: 1) do |connection|
      end
    end
  end

  def test_read
    assert_timeout(Thrift::TransportException) do
      RBHive.tcli_connect(read_host, read_port, timeout: 1) do |connection|
      end
    end
  end
end
