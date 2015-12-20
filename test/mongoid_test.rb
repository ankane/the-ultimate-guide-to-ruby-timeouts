require_relative "test_helper"

class MongoidTest < Minitest::Test
  def test_connect
    Mongoid.load_configuration(clients: {
      default: {
        database: "ultimate_test",
        hosts: [connect_host],
        options: {
          connect_timeout: 1,
          server_selection_timeout: 1
        }
      }
    })

    assert_timeout(Mongo::Error::NoServerAvailable) do
      Mongoid::Clients.default[:artists].find.count
    end
  end
end
