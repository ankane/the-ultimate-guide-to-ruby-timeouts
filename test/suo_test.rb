require_relative "test_helper"

class SuoTest < Minitest::Test
  # raises Suo::LockClientError when Memcached not reachable
  def test_memcached
    suo = Suo::Client::Memcached.new("test_key", client: Dalli::Client.new, ttl: 2, acquisition_timeout: 0.1)
    token = suo.lock
    refute_nil token
    assert_nil suo.lock
  ensure
    suo.unlock(token) if token
  end

  # raises Suo::LockClientError when Redis not reachable
  def test_redis
    suo = Suo::Client::Redis.new("test_key", client: Redis.new, ttl: 2, acquisition_timeout: 0.1)
    token = suo.lock
    refute_nil token
    assert_nil suo.lock
  ensure
    suo.unlock(token) if token
  end
end
