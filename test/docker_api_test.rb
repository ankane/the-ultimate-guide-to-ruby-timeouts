require_relative "test_helper"

class DockerApiTest < Minitest::Test
  def test_connect
    Docker.url = "tcp://#{connect_host}"
    Docker.options = {
      connect_timeout: 1
    }

    assert_timeout(Docker::Error::TimeoutError, timeout: 4) do
      Docker.version
    end
  end

  def test_read
    Docker.url = "tcp://#{read_host_and_port}"
    Docker.options = {
      read_timeout: 1
    }

    # 4 retries
    assert_timeout(Docker::Error::TimeoutError, timeout: 4) do
      Docker.version
    end
  end
end
