require_relative "test_helper"

require "google/protobuf"

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "requester.Config" do
    optional :name, :string, 1
  end
  add_message "requester.Response" do
    optional :message, :string, 1
  end
end

module Requester
  Config = Google::Protobuf::DescriptorPool.generated_pool.lookup("requester.Config").msgclass
  Response = Google::Protobuf::DescriptorPool.generated_pool.lookup("requester.Response").msgclass
end

module Requester
  module Requester
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'requester.Requester'

      rpc :Process, Config, Response
    end

    Stub = Service.rpc_stub_class
  end
end

class GrpcTest < Minitest::Test
  def test_connect
    stub = Requester::Requester::Stub.new("#{connect_host}:50051", :this_channel_is_insecure, timeout: 1)
    assert_timeout(GRPC::DeadlineExceeded) do
      stub.process(Requester::Config.new(name: "Mark"))
    end
  end

  def test_read
    stub = Requester::Requester::Stub.new(read_host_and_port, :this_channel_is_insecure, timeout: 1)
    assert_timeout(GRPC::DeadlineExceeded) do
      stub.process(Requester::Config.new(name: "Mark"))
    end
  end
end
