require_relative "test_helper"

class MechanizeTest < Minitest::Test
  def test_connect
    agent = Mechanize.new
    agent.open_timeout = 1
    assert_timeout(Net::OpenTimeout) do
      agent.get(connect_url)
    end
  end

  def test_read
    agent = Mechanize.new
    agent.read_timeout = 1
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      agent.get(read_url)
    end
  end
end
