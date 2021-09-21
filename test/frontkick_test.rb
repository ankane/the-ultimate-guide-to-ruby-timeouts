require_relative "test_helper"

class FrontkickTest < Minitest::Test
  def setup
    # https://github.com/sonots/frontkick/pull/13
    skip if ruby3?
  end

  def test_timeout
    assert_timeout(Frontkick::Timeout) do
      Frontkick.exec("sleep 10", timeout: 1)
    end
  end
end
