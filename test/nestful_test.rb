require_relative "test_helper"

class NestfulResource < Nestful::Resource
  options timeout: 1
end

class NestfulTest < Minitest::Test
  def test_connect
    assert_timeout(Nestful::TimeoutError) do
      Nestful::Request.new(connect_url, timeout: 1).execute
    end
  end

  def test_read
    assert_timeout(Nestful::TimeoutError) do
      Nestful::Request.new(read_url, timeout: 1).execute
    end
  end

  def test_connect_resource
    NestfulResource.endpoint = connect_url

    assert_timeout(Nestful::TimeoutError) do
      NestfulResource.get
    end
  end

  def test_read_resource
    NestfulResource.endpoint = read_url

    assert_timeout(Nestful::TimeoutError) do
      NestfulResource.get
    end
  end
end
