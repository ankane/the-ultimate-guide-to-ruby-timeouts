require_relative "test_helper"

class MlanettRedisLockTest < Minitest::Test
  def test_acquire
    redis = Redis.new
    redis.lock("test", life: 1, acquire: 1, owner: "pid1")
    assert_timeout(Redis::Lock::LockNotAcquired) do
      redis.lock("test", life: 1, acquire: 1, owner: "pid2")
    end
  end
end
