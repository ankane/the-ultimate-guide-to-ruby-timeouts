require_relative "test_helper"

Vault.configure do |config|
  config.timeout = 1
end

class VaultTest < Minitest::Test
  def test_connect
    Vault.address = connect_url
    assert_timeout(Vault::HTTPConnectionError) do
      Vault.sys.mounts
    end
  end

  def test_read
    Vault.address = read_url
    assert_timeout(Vault::HTTPConnectionError) do
      Vault.sys.mounts
    end
  end
end
