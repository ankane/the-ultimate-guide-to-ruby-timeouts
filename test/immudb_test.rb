require_relative "test_helper"

class ImmudbTest < Minitest::Test
  def test_connect
    assert_timeout(GRPC::DeadlineExceeded) do
      Immudb::Client.new(host: connect_host, timeout: 1).list_databases
    end
  end

  def test_read
    assert_timeout(GRPC::DeadlineExceeded) do
      Immudb::Client.new(host: read_host, port: read_port, timeout: 1).list_databases
    end
  end
end
