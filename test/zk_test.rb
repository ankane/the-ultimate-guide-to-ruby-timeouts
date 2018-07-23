require_relative "test_helper"

class ZkTest < Minitest::Test
  def test_connect
    skip # doesn't work

    zk = ZK.new("#{connect_host}:2181", receive_timeout_msec: 1000)
    assert_timeout(Zookeeper::Exceptions::ContinuationTimeoutError) do
      zk.children("/path")
    end
  end

  def test_read
    skip # doesn't work

    zk = ZK.new(read_host_and_port, receive_timeout_msec: 1000)
    assert_timeout(Zookeeper::Exceptions::ContinuationTimeoutError) do
      zk.children("/path")
    end
  end
end
