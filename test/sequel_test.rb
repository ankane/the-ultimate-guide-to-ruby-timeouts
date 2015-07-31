require_relative "test_helper"

class SequelTest < Minitest::Test
  def test_connect_postgresql
    db = Sequel.connect adapter: "postgresql", host: connect_host, connect_timeout: 1
    assert_timeout(Sequel::DatabaseConnectionError) { db["SELECT 1"].to_a }
  end

  def test_read_postgresql
    db = Sequel.connect adapter: "postgresql", host: read_host, port: read_port, connect_timeout: 1
    assert_timeout(Sequel::DatabaseConnectionError) { db["SELECT 1"].to_a }
  end

  def test_connect_mysql2
    db = Sequel.connect adapter: "mysql2", host: connect_host, connect_timeout: 1
    assert_timeout(Sequel::DatabaseConnectionError) { db["SELECT 1"].to_a }
  end

  def test_read_mysql2
    db = Sequel.connect adapter: "mysql2", host: read_host, port: read_port, connect_timeout: 1
    assert_timeout(Sequel::DatabaseConnectionError) { db["SELECT 1"].to_a }
  end

  def test_checkout_postgresql
    db = Sequel.connect adapter: "postgresql", max_connections: 1, pool_timeout: 1, database: "ultimate_test"
    assert_threaded_timeout(Sequel::PoolTimeout) do
      db["SELECT pg_sleep(2)"].to_a
    end
  end

  def test_checkout_mysql2
    db = Sequel.connect adapter: "mysql2", max_connections: 1, pool_timeout: 1, database: "ultimate_test", user: "root"
    assert_threaded_timeout(Sequel::PoolTimeout) do
      db["SELECT sleep(2)"].to_a
    end
  end
end
