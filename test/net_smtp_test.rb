require_relative "test_helper"
require "net/smtp"

class NetSmtpTest < Minitest::Test
  def test_connect
    smtp = Net::SMTP.new(connect_host, 25)
    smtp.open_timeout = 1
    assert_timeout(Net::OpenTimeout) do
      smtp.start do |smtp2|
        smtp2.capable_auth_types
      end
    end
  end

  def test_read
    smtp = Net::SMTP.new(read_host, read_port)
    smtp.read_timeout = 1
    assert_timeout(Net::ReadTimeout) do
      smtp.start do |smtp2|
        smtp2.capable_auth_types
      end
    end
  end
end
