require_relative "test_helper"

class PgTest < Minitest::Test
  def test_connect
    assert_timeout(PG::ConnectionBad) do
      PG.connect(host: connect_host, connect_timeout: 1)
    end
  end

  def test_read
    assert_timeout(PG::ConnectionBad) do
      PG.connect(host: read_host, port: read_port, connect_timeout: 1)
    end
  end
end
