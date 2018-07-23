require_relative "test_helper"

class PwnedTest < Minitest::Test
  def test_connect
    Pwned::Password.send(:remove_const, "API_URL")
    Pwned::Password.const_set("API_URL", "#{connect_url}/")

    assert_timeout(Pwned::TimeoutError) do
      Pwned::Password.new("test", open_timeout: 1).pwned?
    end
  end

  def test_read
    Pwned::Password.send(:remove_const, "API_URL")
    Pwned::Password.const_set("API_URL", "#{read_url}/")

    assert_timeout(Pwned::TimeoutError) do
      Pwned::Password.new("test", read_timeout: 1).pwned?
    end
  end
end
