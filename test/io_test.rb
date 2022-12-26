require_relative "test_helper"

class IoTest < Minitest::Test
  def setup
    skip if RUBY_VERSION.to_f < 3.2
  end

  def test_timeout
    previous_timeout = STDIN.timeout
    begin
      STDIN.timeout = 1

      assert_timeout(IO::TimeoutError) do
        STDIN.read
      end
    ensure
      STDIN.timeout = previous_timeout
    end
  end
end
