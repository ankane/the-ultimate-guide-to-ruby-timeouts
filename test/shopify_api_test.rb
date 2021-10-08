require_relative "test_helper"

class ShopifyApiTest < Minitest::Test
  def test_connect
    ShopifyAPI::Base.site = connect_url
    ShopifyAPI::Base.api_version = "2019-04"
    ShopifyAPI::Base.timeout = 1

    assert_timeout(ActiveResource::TimeoutError) do
      ShopifyAPI::Shop.current
    end
  end

  def test_read
    ShopifyAPI::Base.site = read_url
    ShopifyAPI::Base.api_version = "2019-04"
    ShopifyAPI::Base.timeout = 1

    assert_timeout(ActiveResource::TimeoutError, timeout: 2) do
      ShopifyAPI::Shop.current
    end
  end
end
