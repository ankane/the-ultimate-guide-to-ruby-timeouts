require_relative "test_helper"

class Person < ActiveResource::Base
end

class ActiveResourceTest < Minitest::Test
  def test_connect
    Person.site = connect_url
    Person.open_timeout = 1
    assert_timeout(ActiveResource::TimeoutError) do
      Person.first
    end
  end

  def test_read
    Person.site = read_url
    Person.read_timeout = 1
    assert_timeout(ActiveResource::TimeoutError, timeout: 2) do
      Person.first
    end
  end
end
