require_relative "test_helper"

class HttppartyResource
  include HTTParty

  default_timeout 1
end

class HttpartyTest < Minitest::Test
  def test_connect
    assert_timeout(Net::OpenTimeout) do
      HTTParty.get(connect_url, timeout: 1)
    end
  end

  def test_read
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      HTTParty.get(read_url, timeout: 1)
    end
  end

  def test_connect_resource
    assert_timeout(Net::OpenTimeout) do
      HttppartyResource.get(connect_url)
    end
  end

  def test_read_resource
    assert_timeout(Net::ReadTimeout, timeout: 2) do
      HttppartyResource.get(read_url)
    end
  end
end
