require_relative "test_helper"

class IntercomTest < Minitest::Test
  def test_connect
    client = Intercom::Client.new(token: 'IntercomToken', base_url: connect_url)
    client.options(Intercom::Client.set_timeouts(open_timeout: 1))

    assert_timeout(Intercom::ServiceConnectionError) do
      client.users.find(id: "42")
    end
  end

  def test_read
    client = Intercom::Client.new(token: 'IntercomToken', base_url: read_url)
    client.options(Intercom::Client.set_timeouts(read_timeout: 1))

    assert_timeout(Intercom::ServiceUnavailableError, timeout: 2) do
      client.users.find(id: "42")
    end
  end
end
