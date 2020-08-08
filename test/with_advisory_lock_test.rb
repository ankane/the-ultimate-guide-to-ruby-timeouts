require_relative "test_helper"

class WithAdvisoryLockTest < Minitest::Test
  def test_postgresql
    ActiveRecord::Base.establish_connection adapter: "postgresql", database: "ultimate_test"
    results = with_threads do
      ActiveRecord::Base.with_advisory_lock("123", timeout_seconds: 1) do
        sleep(2)
      end
    end
    assert_includes results, false
  end

  def test_mysql
    ActiveRecord::Base.establish_connection adapter: "mysql2", database: "ultimate_test"
    results = with_threads do
      ActiveRecord::Base.with_advisory_lock("123", timeout_seconds: 1) do
        sleep(2)
      end
    end
    assert_includes results, false
  end
end
