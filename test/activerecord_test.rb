require_relative "test_helper"

class ActiveRecordTest < Minitest::Test
  def test_connect_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", host: connect_host, connect_timeout: 1
    assert_timeout(PG::ConnectionBad) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  def test_read_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", host: read_host, port: read_port, connect_timeout: 1
    assert_timeout(PG::ConnectionBad) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  def test_connect_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", host: connect_host, connect_timeout: 1
    assert_timeout(Mysql2::Error::ConnectionError) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  def test_read_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", host: read_host, port: read_port, connect_timeout: 1
    assert_timeout(Mysql2::Error::ConnectionError) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  def test_checkout_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", pool: 1, checkout_timeout: 1, database: "ultimate_test"
    assert_threaded_timeout(ActiveRecord::ConnectionTimeoutError) do
      ActiveRecord::Base.connection.execute("SELECT pg_sleep(2)")
    end
  end

  def test_checkout_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", pool: 1, checkout_timeout: 1, database: "ultimate_test"
    assert_threaded_timeout(ActiveRecord::ConnectionTimeoutError) do
      ActiveRecord::Base.connection.execute("SELECT sleep(2)")
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
    skip if travis?

    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test", variables: {max_execution_time: 250}
    assert_timeout(ActiveRecord::StatementTimeout, timeout: 0.250) do
      ActiveRecord::Base.connection.execute("SELECT 1 FROM information_schema.tables WHERE sleep(1)")
    end
  end

  def test_statement_mysql2_inline
    skip if travis?

    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test"
    assert_timeout(ActiveRecord::StatementTimeout, timeout: 0.250) do
      ActiveRecord::Base.connection.execute("SELECT /*+ MAX_EXECUTION_TIME(250) */ 1 FROM information_schema.tables WHERE sleep(1)")
    end
  end
end
