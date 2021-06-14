require_relative "test_helper"

class FaktoryWorkerRubyTest < Minitest::Test
  class FaktoryJob
    include Faktory::Job
    def perform(*_args); end
  end

  def test_connect
    assert_timeout(Faktory::TimeoutError) do
      Faktory::Client.new(url: "tcp://#{connect_host}:7419", timeout: 0.5)
    end
  end

  def test_read
    Faktory.faktory = { timeout: 0.5, url: "#{read_url}" }
    assert_timeout(Faktory::TimeoutError) do
      FaktoryWorkerRubyTest::FaktoryJob.perform_async
    end
  end
end
