require_relative "test_helper"
require "net/ldap"

class NetLdapTest < Minitest::Test
  def test_connect
    ldap = Net::LDAP.new(host: connect_host, connect_timeout: 1)

    assert_timeout(Net::LDAP::Error) do
      ldap.bind
    end
  end

  def test_read
    skip "No read timeout"

    ldap = Net::LDAP.new(host: read_host, port: read_port)

    assert_timeout(Net::LDAP::Error) do
      ldap.bind
    end
  end
end
