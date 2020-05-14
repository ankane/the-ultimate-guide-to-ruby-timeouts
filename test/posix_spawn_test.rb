require_relative "test_helper"

class PosixSpawnTest < Minitest::Test
  def test_timeout
    assert_timeout(POSIX::Spawn::TimeoutExceeded) do
      POSIX::Spawn::Child.new("sleep 10", timeout: 1)
    end
  end
end
