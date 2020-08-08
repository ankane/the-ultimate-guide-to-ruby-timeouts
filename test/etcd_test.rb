require_relative "test_helper"

class EtcdTest < Minitest::Test
  def test_connect
    skip "No open timeout"

    client = Etcd.client(host: connect_host, read_timeout: 1)
    assert_timeout(Net::OpenTimeout) do
      client.get("/nodes/n1")
    end
  end

  def test_read
    client = Etcd.client(host: read_host, port: read_port, read_timeout: 1)
    assert_timeout(Net::ReadTimeout) do
      client.get("/nodes/n1")
    end
  end
end
