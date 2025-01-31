require_relative "test_helper"

class ActiveRecordTest < Minitest::Test
  def test_connect_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", host: connect_host, connect_timeout: 1, connection_retries: 0
    assert_timeout(ActiveRecord::DatabaseConnectionError) do
      ActiveRecord::Base.connection.execute("SELECT 1")
    end
  end

  def test_read_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", host: read_host, port: read_port, connect_timeout: 1, connection_retries: 0
    assert_timeout(ActiveRecord::DatabaseConnectionError) do
      ActiveRecord::Base.connection.execute("SELECT 1")
    end
  end

  def test_connect_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", host: connect_host, connect_timeout: 1, connection_retries: 0
    assert_timeout(ActiveRecord::DatabaseConnectionError) do
      ActiveRecord::Base.connection.execute("SELECT 1")
    end
  end

  def test_read_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", host: read_host, port: read_port, connect_timeout: 1, connection_retries: 0
    assert_timeout(ActiveRecord::ConnectionNotEstablished) do
      ActiveRecord::Base.connection.execute("SELECT 1")
    end
  end

  def test_checkout_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", pool: 1, checkout_timeout: 1, database: "ultimate_test"
    assert_threaded_timeout(ActiveRecord::ConnectionTimeoutError) do
      ActiveRecord::Base.connection.execute("SELECT pg_sleep(1.1)")
    end
  end

  def test_checkout_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", pool: 1, checkout_timeout: 1, database: "ultimate_test"
    assert_threaded_timeout(ActiveRecord::ConnectionTimeoutError) do
      ActiveRecord::Base.connection.execute("SELECT sleep(1.1)")
    end
  end

  def test_statement_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", database: "ultimate_test", variables: {statement_timeout: 250}
    assert_timeout(ActiveRecord::QueryCanceled, timeout: 0.250) do
      ActiveRecord::Base.connection.execute("SELECT pg_sleep(1)")
    end
  end

  def test_statement_postgresql_local
    ActiveRecord::Base.establish_connection adapter: "postgresql", database: "ultimate_test"
    assert_timeout(ActiveRecord::QueryCanceled, timeout: 0.250) do
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("SET LOCAL statement_timeout = 250")
        ActiveRecord::Base.connection.execute("SELECT pg_sleep(1)")
      end
    end
  end

  def test_statement_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test", variables: {max_execution_time: 250}
    assert_timeout(ActiveRecord::StatementTimeout, timeout: 0.250) do
      ActiveRecord::Base.connection.execute("SELECT 1 FROM information_schema.tables WHERE sleep(1)")
    end
  end

  def test_statement_mysql2_inline
    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test"
    assert_timeout(ActiveRecord::StatementTimeout, timeout: 0.250) do
      ActiveRecord::Base.connection.execute("SELECT /*+ MAX_EXECUTION_TIME(250) */ 1 FROM information_schema.tables WHERE sleep(1)")
    end
  end

  def test_advisory_lock_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", database: "ultimate_test"
    results = with_threads do
      ActiveRecord::Base.connection.get_advisory_lock(123)
    end
    assert_includes results, true
    assert_includes results, false
  end

  def test_advisory_lock_mysql
    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test"
    results = with_threads do
      ActiveRecord::Base.connection.get_advisory_lock(123)
    end
    assert_includes results, true
    assert_includes results, false
  end
end
