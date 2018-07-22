require_relative "test_helper"
require "cassandra"

class CassandraDriverTest < Minitest::Test
  def test_connect
    assert_timeout(Cassandra::Errors::NoHostsAvailable) do
      Cassandra.cluster(hosts: [connect_host], connect_timeout: 1)
    end
  end

  def test_read
    assert_timeout(Cassandra::Errors::NoHostsAvailable) do
      Cassandra.cluster(hosts: [read_host], port: read_port, timeout: 1)
    end
  end
end
