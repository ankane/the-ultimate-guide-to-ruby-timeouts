require_relative "test_helper"

class MixlibShelloutTest < Minitest::Test
  def test_timeout
    command = "for i in `seq 1 10`; do echo $i; sleep 1.2; done"
    shell = Mixlib::ShellOut.new(command, timeout: 1)
    # there are a few seconds of setup time, so set timeout to 4
    assert_timeout(Mixlib::ShellOut::CommandTimeout, timeout: 4) do
      shell.run_command
    end
    assert_equal "1\n", shell.stdout
  end
end
