require_relative "test_helper"

class MailTest < Minitest::Test
  def setup
    @mail =
      Mail.new do
        from     'me@test.lindsaar.net'
        to       'you@test.lindsaar.net'
        subject  'Here is the image you wanted'
        body     'boom'
      end
  end

  def test_connect
    @mail.delivery_method :smtp, address: connect_host, open_timeout: 1
    assert_timeout(Net::OpenTimeout) do
      @mail.deliver
    end
  end

  def test_read
    @mail.delivery_method :smtp, address: read_host, port: read_port, read_timeout: 1
    assert_timeout(Net::ReadTimeout) do
      @mail.deliver
    end
  end
end
