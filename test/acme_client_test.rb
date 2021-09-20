require_relative "test_helper"

class AcmeClientTest < Minitest::Test
  def test_connect
    private_key = OpenSSL::PKey::RSA.new(4096)
    client = Acme::Client.new(
      private_key: private_key,
      directory: connect_url,
      connection_options: {request: {open_timeout: 1}}
    )

    assert_timeout(Acme::Client::Error::Timeout) do
      client.new_account(contact: "mailto:info@example.com", terms_of_service_agreed: true)
    end
  end

  def test_read
    private_key = OpenSSL::PKey::RSA.new(4096)
    client = Acme::Client.new(
      private_key: private_key,
      directory: read_url,
      connection_options: {request: {timeout: 1}}
    )

    assert_timeout(Acme::Client::Error::Timeout) do
      client.new_account(contact: "mailto:info@example.com", terms_of_service_agreed: true)
    end
  end
end
