require_relative "test_helper"

class PgTest < Minitest::Test
  def test_connect
    assert_timeout(PG::ConnectionBad) { PG.connect(host: connect_host, connect_timeout: 1) }
  end
end
