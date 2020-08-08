require_relative "test_helper"

class SuoTest < Minitest::Test
  def test_acquire
    suo = Suo::Client::Redis.new("test_key", client: Redis.new, ttl: 2, acquisition_timeout: 0.1)
    token = suo.lock
    refute_nil token
    assert_nil suo.lock
  ensure
    suo.unlock(token) if token
  end
end
