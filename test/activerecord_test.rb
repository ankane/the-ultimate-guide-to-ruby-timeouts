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
    assert_timeout(Mysql2::Error) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end

  def test_read_mysql2
    ActiveRecord::Base.establish_connection adapter: "mysql2", host: read_host, port: read_port, connect_timeout: 1
    assert_timeout(Mysql2::Error) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end
end
