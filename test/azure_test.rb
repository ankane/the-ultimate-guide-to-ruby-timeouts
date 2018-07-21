require_relative "test_helper"

class AzureTest < Minitest::Test
  def test_connect
    skip

    settings = MsRestAzure::ActiveDirectoryServiceSettings.new
    settings.authentication_endpoint = "#{connect_url}/"

    options = {
      tenant_id: "test",
      client_id: "test",
      client_secret: "test",
      subscription_id: "test",
      active_directory_settings: settings
    }

    profile_client = Azure::Compute::Profiles::Latest::Mgmt::Client.new(options)
    profile_client.virtual_machines.get("RESOURCE_GROUP_NAME", "VIRTUAL_MACHINE_NAME")
  end
end
