require_relative "test_helper"

class GeocoderTest < Minitest::Test
  def test_connect
    Geocoder.configure(timeout: 1, always_raise: :all, lookup: :dstk, dstk: {host: connect_host})
    assert_timeout(Geocoder::LookupTimeout) do
      Geocoder.search("123 main st")
    end
  end

  def test_read
    Geocoder.configure(timeout: 1, always_raise: :all, lookup: :dstk, dstk: {host: read_host_and_port})
    assert_timeout(Geocoder::LookupTimeout, timeout: 2) do
      Geocoder.search("123 main st")
    end
  end
end
