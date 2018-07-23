require_relative "test_helper"

class ZookeeperTest < Minitest::Test
  def test_connect
    skip # doesn't work

    z = Zookeeper.new("#{connect_host}:2181")
    assert_timeout(Zookeeper::Exceptions::ContinuationTimeoutError) do
      z.get_children(path: "/")
    end
  end

  def test_read
    skip # doesn't work

    z = Zookeeper.new(read_host_and_port)
    assert_timeout(Zookeeper::Exceptions::ContinuationTimeoutError) do
      z.get_children(path: "/")
    end
  end
end
