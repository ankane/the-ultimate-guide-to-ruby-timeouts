require_relative "test_helper"

class FrontkickTest < Minitest::Test
  def setup
    skip if ruby3?
  end

  def test_timeout
    assert_timeout(Frontkick::Timeout) do
      Frontkick.exec("sleep 10", timeout: 1)
    end
  end
end
