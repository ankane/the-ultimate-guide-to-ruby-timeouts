require_relative "test_helper"

class User < Spyke::Base
end

class SpykeTest < Minitest::Test
  def test_connect
    Spyke::Base.connection = Faraday.new(url: connect_url) do |c|
      c.adapter Faraday.default_adapter
      c.options[:open_timeout] = 1
    end

    assert_timeout(Spyke::ConnectionError) do
      User.find(1)
    end
  end

  def test_read
    Spyke::Base.connection = Faraday.new(url: read_url) do |c|
      c.adapter Faraday.default_adapter
      c.options[:timeout] = 1
    end

    assert_timeout(Spyke::ConnectionError) do
      User.find(1)
    end
  end
end
