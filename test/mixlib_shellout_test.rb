require_relative "test_helper"

class MixlibShelloutTest < Minitest::Test
  def test_timeout
    assert_timeout(Mixlib::ShellOut::CommandTimeout) do
      Mixlib::ShellOut.new("sleep 10", timeout: 1).run_command
    end
  end
end
