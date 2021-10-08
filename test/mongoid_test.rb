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

    assert_timeout(Mongo::Error::NoServerAvailable, timeout: 4) do
      Mongoid::Clients.default[:artists].find.count
    end
  end

  def test_read
    Mongoid.load_configuration(clients: {
      default: {
        database: "ultimate_test",
        hosts: [read_host_and_port],
        options: {
          connect_timeout: 1,
          server_selection_timeout: 1
        }
      }
    })

    assert_timeout(Mongo::Error::NoServerAvailable, timeout: 2) do
      Mongoid::Clients.default[:artists].find.count
    end
  end
end
