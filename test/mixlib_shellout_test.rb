require_relative "test_helper"

class MixlibShelloutTest < Minitest::Test
  def test_timeout
    command = "for i in `seq 1 100`; do sleep 0.1; echo $i; done"
    shell = Mixlib::ShellOut.new(command, timeout: 1)
    # there are a few seconds of setup time, so set timeout to 4
    assert_timeout(Mixlib::ShellOut::CommandTimeout, timeout: 4) do
      shell.run_command
    end
    # can go slightly over
    refute_match "13", shell.stdout
  end
end
