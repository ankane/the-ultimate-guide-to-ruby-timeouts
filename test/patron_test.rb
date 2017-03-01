require_relative "test_helper"

class PatronTest < Minitest::Test
  def test_connect
    # throws Patron::TimeoutError locally
    # occasionally throws Patron::ConnectionFailed on Travis
    assert_timeout(Patron::Error) do
      sess = Patron::Session.new
      sess.base_url = connect_url
      sess.connect_timeout = 1
      sess.get("/")
    end
  end

  def test_read
    assert_timeout(Patron::TimeoutError) do
      sess = Patron::Session.new
      sess.base_url = read_url
      sess.timeout = 1
      sess.get("/")
    end
  end
end
