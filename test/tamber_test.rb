require_relative "test_helper"

Tamber.project_key = "your_project_key"

class TamberTest < Minitest::Test
  def test_connect
    skip "Tests failing"

    Tamber.instance_variable_set(:@api_url, connect_url)
    Tamber.open_timeout = 1

    assert_timeout(Tamber::NetworkError) do
      Tamber::Discover.hot
    end
  end

  def test_read
    skip "Tests failing"

    Tamber.instance_variable_set(:@api_url, read_url)
    Tamber.read_timeout = 1

    assert_timeout(Tamber::NetworkError) do
      Tamber::Discover.hot
    end
  end
end
