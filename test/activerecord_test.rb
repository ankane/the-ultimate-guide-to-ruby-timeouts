require_relative "test_helper"

class ActiveRecordTest < Minitest::Test
  def test_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", host: connect_host, connect_timeout: 1
    assert_timeout(PG::ConnectionBad) { ActiveRecord::Base.connection.execute("SELECT 1") }
  end
end
