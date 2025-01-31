require_relative "test_helper"
require "action_mailer"

class Mailer < ActionMailer::Base
  def hi
    mail to: "to@example.com", from: "from@example.com", subject: "hi", body: ""
  end
end

class ActionMailerTest < Minitest::Test
  def setup
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.delivery_method = :smtp
  end

  def test_connect
    ActionMailer::Base.smtp_settings = {
      address: connect_host,
      open_timeout: 1
    }
    assert_timeout(Net::OpenTimeout, timeout: 1.5) do
      Mailer.hi.deliver_now
    end
  end

  def test_read
    ActionMailer::Base.smtp_settings = {
      address: read_host,
      port: read_port,
      read_timeout: 1
    }
    assert_timeout(Net::ReadTimeout) do
      Mailer.hi.deliver_now
    end
  end
end
