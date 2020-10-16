require_relative "test_helper"

class JiraRubyTest < Minitest::Test
  def test_read
    client =
      JIRA::Client.new(
        site: read_url,
        use_ssl: false,
        auth_type: :basic,
        read_timeout: 1
      )

    assert_timeout(Net::ReadTimeout) do
      client.Project.all
    end
  end
end
