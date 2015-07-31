require_relative "test_helper"

class MongoidTest < Minitest::Test
  def test_connect
    Mongoid.load_configuration(sessions: {
      default: {
        database: "ultimate_test",
        hosts: [connect_host],
        options: {
          timeout: 1,
          max_retries: 0
        }
      }
    })

    assert_timeout(Moped::Errors::ConnectionFailure) do
      Mongoid::Sessions.default[:artists].find.count
    end
  end
end
