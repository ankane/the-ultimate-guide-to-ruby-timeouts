require_relative "test_helper"

class RedlockTest < Minitest::Test
  def test_acquire
    lock_manager = Redlock::Client.new([Redis.new], retry_count: 0)
    lock_manager.lock("key", 1000)
    refute lock_manager.lock("key", 1000)
    assert_timeout(Redlock::LockError) do
      lock_manager.lock!("key", 1000) do
      end
    end
  end
end
