require_relative "test_helper"

class FaktoryWorkerRubyTest < Minitest::Test
  class FaktoryJob
    include Faktory::Job
    def perform(*_args); end
  end

  def test_read
    Faktory.faktory = { timeout: 1, url: "#{read_url}" }
    assert_timeout(Faktory::TimeoutError) do
      FaktoryWorkerRubyTest::FaktoryJob.perform_async
    end
  end
end
