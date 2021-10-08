require_relative "test_helper"

class AirtableTest < Minitest::Test
  def test_connect
    Airtable::Table.base_uri connect_url
    Airtable::Resource.default_timeout 1

    assert_timeout(Net::OpenTimeout) do
      Airtable::Client.new("key").table("table", "table").all
    end
  end

  def test_read
    Airtable::Table.base_uri read_url
    Airtable::Resource.default_timeout 1

    assert_timeout(Net::ReadTimeout, timeout: 2) do
      Airtable::Client.new("key").table("table", "table").all
    end
  end
end
