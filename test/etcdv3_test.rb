require_relative "test_helper"

class EtcdTest < Minitest::Test
  def test_connect
    conn = Etcdv3.new(endpoints: "http://#{connect_host}:2379", command_timeout: 1)
    assert_timeout(GRPC::DeadlineExceeded) do
      conn.get("test")
    end
  end

  def test_read
    conn = Etcdv3.new(endpoints: read_url, command_timeout: 1)
    assert_timeout(GRPC::DeadlineExceeded) do
      conn.get("test")
    end
  end

  def test_request
    conn = Etcdv3.new(endpoints: "http://#{connect_host}:2379")
    assert_timeout(GRPC::DeadlineExceeded) do
      conn.get("test", timeout: 1)
    end
  end
end
