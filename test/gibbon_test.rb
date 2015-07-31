require_relative "test_helper"

class GibbonTest < Minitest::Test
  def test_connect
    assert_timeout(Gibbon::MailChimpError) do
      Gibbon::Request.new(api_key: "boom", api_endpoint: connect_url, timeout: 1).lists.retrieve
    end
  end

  def test_read
    assert_timeout(Gibbon::MailChimpError) do
      Gibbon::Request.new(api_key: "boom", api_endpoint: read_url, timeout: 1).lists.retrieve
    end
  end
end
