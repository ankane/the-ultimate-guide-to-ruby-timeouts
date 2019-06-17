require_relative "test_helper"

class ClearbitTest < Minitest::Test
  def test_connect
    Clearbit::Enrichment::PersonCompany.endpoint = connect_url
    Clearbit::Resource.options = {timeout: 1}

    assert_timeout(Nestful::TimeoutError) do
      Clearbit::Enrichment.find(email: "test@example.com")
    end
  end

  def test_read
    Clearbit::Enrichment::PersonCompany.endpoint = read_url
    Clearbit::Resource.options = {timeout: 1}

    assert_timeout(Nestful::TimeoutError) do
      Clearbit::Enrichment.find(email: "test@example.com")
    end
  end
end
