require_relative "test_helper"

class TtyCommandTest < Minitest::Test
  def test_timeout
    assert_timeout(TTY::Command::TimeoutExceeded) do
      TTY::Command.new.run("sleep 10", timeout: 1)
    end
  end

  def test_timeout_all
    assert_timeout(TTY::Command::TimeoutExceeded) do
      TTY::Command.new(timeout: 1).run("sleep 10")
    end
  end
end
