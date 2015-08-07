require_relative "test_helper"
require "action_mailer"

class Mailer < ActionMailer::Base
  def hi
    mail(to: "to@example.com", from: "from@example.com", subject: "hi", body: "")
  end
end

class ActionMailerTest < Minitest::Test
  def setup
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.delivery_method = :smtp
  end

  def test_connect
    skip
    ActionMailer::Base.smtp_settings = {
      address: connect_host
    }
    Mailer.hi.deliver_now
  end

  def test_read
    skip
  end
end
