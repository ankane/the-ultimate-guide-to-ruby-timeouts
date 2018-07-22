require_relative "test_helper"

class DogApiTest < Minitest::Test
  def test_connect
    dog = Dogapi::Client.new("test", nil, nil, nil, false, 1, connect_url)

    assert_timeout(Net::OpenTimeout) do
      dog.emit_point("some.metric.name", 50.0)
    end
  end

  def test_read
    dog = Dogapi::Client.new("test", nil, nil, nil, false, 1, read_url)

    assert_timeout(Net::ReadTimeout) do
      dog.emit_point("some.metric.name", 50.0)
    end
  end
end
