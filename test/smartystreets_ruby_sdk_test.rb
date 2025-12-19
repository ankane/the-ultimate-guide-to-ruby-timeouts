require_relative "test_helper"

class SmartystreetsRubySdkTest < Minitest::Test
  def test_connect
    credentials = SmartyStreets::StaticCredentials.new("auth_id", "auth_token")
    client = SmartyStreets::ClientBuilder.new(credentials).with_base_url(connect_url).with_max_timeout(1).retry_at_most(0).build_us_street_api_client
    lookup = SmartyStreets::USStreet::Lookup.new("test")

    assert_timeout(Net::OpenTimeout) do
      client.send_lookup(lookup)
    end
  end

  def test_read
    skip "Doesn't work with non-ssl"

    credentials = SmartyStreets::StaticCredentials.new("auth_id", "auth_token")
    client = SmartyStreets::ClientBuilder.new(credentials).with_base_url(read_url).with_max_timeout(1).retry_at_most(0).build_us_street_api_client
    lookup = SmartyStreets::USStreet::Lookup.new("test")

    assert_timeout(Net::ReadTimeout) do
      client.send_lookup(lookup)
    end
  end
end
