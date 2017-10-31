require_relative "test_helper"
require "kafka"

class RubyKafkaTest < Minitest::Test
  def test_connect
    assert_timeout(Kafka::ConnectionError) do
      Kafka.new(seed_brokers: [connect_host], connect_timeout: 1).deliver_message("hi", topic: "hi")
    end
  end

  def test_read
    assert_timeout(Kafka::ConnectionError) do
      Kafka.new(seed_brokers: [read_host_and_port], socket_timeout: 1).deliver_message("hi", topic: "hi")
    end
  end
end
