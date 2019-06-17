require_relative "test_helper"

class RiddleTest < Minitest::Test
  def test_connect
    client = Riddle::Client.new(connect_host)
    client.timeout = 1

    assert_timeout(Riddle::ResponseError) do
      client.query("hi")
    end
  end

  def test_read
    client = Riddle::Client.new(read_host, read_port)
    client.timeout = 1

    assert_timeout(Riddle::ResponseError) do
      client.query("hi")
    end
  end
end
