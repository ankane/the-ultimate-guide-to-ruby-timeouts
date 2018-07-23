require_relative "test_helper"
require "neo4j/core/cypher_session/adaptors/http"
require "typhoeus/adapters/faraday"

class Neo4jTest < Minitest::Test
  def test_connect
    options = {
      faraday_configurator: lambda do |faraday|
        faraday.adapter :typhoeus
        faraday.options[:open_timeout] = 1
      end
    }
    http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new(connect_url, options)
    neo4j_session = Neo4j::Core::CypherSession.new(http_adaptor)

    assert_timeout(Faraday::TimeoutError) do
      neo4j_session.query("MATCH (n) RETURN n LIMIT 10")
    end
  end

  def test_read
    options = {
      faraday_configurator: lambda do |faraday|
        faraday.adapter :typhoeus
        faraday.options[:timeout] = 1
      end
    }
    http_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new(read_url, options)
    neo4j_session = Neo4j::Core::CypherSession.new(http_adaptor)

    assert_timeout(Faraday::TimeoutError) do
      neo4j_session.query("MATCH (n) RETURN n LIMIT 10")
    end
  end
end
