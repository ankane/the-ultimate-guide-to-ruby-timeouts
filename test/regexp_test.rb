require_relative "test_helper"

class RegexpTest < Minitest::Test
  def setup
    skip if RUBY_VERSION.to_f < 3.2
  end

  def test_timeout
    assert_timeout(Regexp::TimeoutError) do
      Regexp.new(/^a*b?a*()\1$/, timeout: 1) =~ "a" * 50000 + "x"
    end
  end

  def test_global
    previous_timeout = Regexp.timeout
    begin
      Regexp.timeout = 1

      assert_timeout(Regexp::TimeoutError) do
        /^a*b?a*()\1$/ =~ "a" * 50000 + "x"
      end
    ensure
      Regexp.timeout = previous_timeout
    end
  end
end
