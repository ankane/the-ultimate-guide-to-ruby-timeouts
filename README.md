# The Ultimate Guide to Timeouts in Ruby

An unresponsive service is worse than a down one. It can tie up your entire system if not handled properly. **All network requests should have a timeout.**

Here’s how to add timeouts for popular Ruby gems. **[All have been tested](test)**. You should [avoid Ruby’s `Timeout` module](http://www.mikeperham.com/2015/05/08/timeout-rubys-most-dangerous-api/). The default is no timeout, unless otherwise specified. Enjoy!

## Common Types

- **connect (or open)** - time to open the connection
- **read (or receive)** - time to receive data after connected
- **write (or send)** - time to send data after connected
- **checkout** - time to checkout a connection from the pool
- **statement** - time to execute a database statement

## Gems

Data Stores

- [activerecord](#activerecord)
- [sequel](#sequel)
- [pg](#pg)
- [mysql2](#mysql2)
- [dalli](#dalli)
- [redis](#redis)
- [connection_pool](#connection_pool)
- [mongo](#mongo)
- [mongoid](#mongoid)
- [bunny](#bunny)
- [elasticsearch](#elasticsearch)
- [searchkick](#searchkick)

HTTP Clients

- [net/http](#nethttp)
- [open-uri](#open-uri)
- [http](#http)
- [httparty](#httparty)
- [httpclient](#httpclient)
- [rest-client](#rest-client)
- [faraday](#faraday)
- [curb](#curb)
- [typhoeus](#typhoeus)

Web Servers

- [unicorn](#unicorn)
- [puma](#puma)

Rack Middleware

- [rack-timeout](#rack-timeout)
- [slowpoke](#slowpoke)

External Services

- [geocoder](#geocoder)
- [twilio-ruby](#twilio-ruby)
- [koala](#koala)
- [twitter](#twitter)
- [stripe](#stripe)
- [zendesk_api](#zendesk_api)
- [hipchat](#hipchat)
- [firebase](#firebase)

Bonus

- [PostgreSQL statement timeouts](#bonus-postgresql-statement-timeouts)

## Data Stores

### activerecord

- #### postgres adapter

  ```ruby
  ActiveRecord::Base.establish_connection(connect_timeout: 1, checkout_timeout: 1, ...)
  ```

  or in `config/database.yml`

  ```yaml
  production:
    connect_timeout: 1
    checkout_timeout: 1
  ```

  Raises

  - `PG::ConnectionBad` on connect and read timeouts
  - `ActiveRecord::ConnectionTimeoutError` on checkout timeout

- #### mysql2 adapter

  ```ruby
  ActiveRecord::Base.establish_connection(connect_timeout: 1, read_timeout: 1, write_timeout: 1, checkout_timeout: 1, ...)
  ```

  or in `config/database.yml`

  ```yaml
  production:
    connect_timeout: 1
    read_timeout: 1
    write_timeout: 1
    checkout_timeout: 1
  ```

  Raises

  - `Mysql2::Error` on connect and read timeouts
  - `ActiveRecord::ConnectionTimeoutError` on checkout timeout

### sequel

- #### postgres adapter

  ```ruby
  Sequel.connect(connect_timeout: 1, pool_timeout: 1, ...)
  ```

  - `Sequel::DatabaseConnectionError` on connect and read timeouts
  - `Sequel::PoolTimeout` on checkout timeout

- #### mysql2 adapter

  ```ruby
  Sequel.connect(timeout: 1, read_timeout: 1, connect_timeout: 1, pool_timeout: 1, ...)
  ```

  Raises

  - `Sequel::DatabaseConnectionError` on connect and read timeouts
  - `Sequel::PoolTimeout` on checkout timeout

### pg

```ruby
PG.connect(connect_timeout: 1, ...)
```

Raises `PG::ConnectionBad`

### mysql2

```ruby
Mysql2::Client.new(connect_timeout: 1, read_timeout: 1, write_timeout: 1, ...)
```

Raises `Mysql2::Error`

### dalli

```ruby
Dalli::Client.new(host, socket_timeout: 1, ...)
```

Default: 0.5s

Raises `Dalli::RingError`

### redis

```ruby
Redis.new(connect_timeout: 1, timeout: 1, ...)
```

Raises

- `Redis::CannotConnectError` on connect timeout
- `Redis::TimeoutError` on read timeout

### connection_pool

```ruby
ConnectionPool.new(timeout: 1) { ... }
```

Raises `Timeout::Error`

### mongo

```ruby
Mongo::Client.new([host], socket_timeout: 1, server_selection_timeout: 1, ...)
```

Raises `Mongo::Error::NoServerAvailable` on connect timeout

TODO read timeout

### mongoid

```yml
production:
  clients:
    default:
      options:
        timeout: 1
```

Raises `Moped::Errors::ConnectionFailure` on connect timeout

TODO read timeout

### bunny

```ruby
Bunny.new(connection_timeout: 1, ...)
```

Raises `Bunny::TCPConnectionFailedForAllHosts` on connect timeout

TODO read timeout

### elasticsearch

```ruby
Elasticsearch::Client.new(transport_options: {request: {timeout: 1}}, ...)
```

Raises

- `Faraday::ConnectionFailed` on connect timeout
- `Faraday::TimeoutError` on read timeout

### searchkick

```ruby
Searchkick.timeout = 1
```

Default: 10s

Raises same exceptions as [elasticsearch](#elasticsearch)

## HTTP Clients

### net/http

```ruby
Net::HTTP.start(host, port, open_timeout: 1, read_timeout: 1) do
  # ...
end
```

Raises

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### open-uri

```ruby
open(url, open_timeout: 1, read_timeout: 1)
```

Raises

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### http

```ruby
HTTP.timeout(connect: 1, read: 1, write: 1).get(url)
```

Raises `HTTP::TimeoutError`

### httparty

```ruby
HTTParty.get(url, timeout: 1)
```

Raises

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### httpclient

```ruby
client = HTTPClient.new
client.connect_timeout = 1
client.receive_timeout = 1
client.send_timeout = 1
client.get(url)
```

Raises

- `HTTPClient::ConnectTimeoutError` on connect timeout
- `HTTPClient::ReceiveTimeoutError` on read timeout

### rest-client

```ruby
RestClient::Request.execute(method: :get, url: url, open_timeout: 1, timeout: 1)
```

Raises `RestClient::RequestTimeout`

### faraday

```ruby
Faraday.get(url) do |req|
  req.options.open_timeout = 1
  req.options.timeout = 1
end
```

or

```
Faraday.new(url, request: {open_timeout: 1, timeout: 1}) do |faraday|
  # ...
end
```

Raises

- `Faraday::ConnectionFailed` on connect timeout
- `Faraday::TimeoutError` on read timeout

### curb

```ruby
curl = Curl::Easy.new(url)
curl.connect_timeout = 1
curl.timeout = 1
curl.perform
```

Raises `Curl::Err::TimeoutError`

### typhoeus

```ruby
response = Typhoeus.get(url, connecttimeout: 1, timeout: 1)
```

No exception is raised. Check for a timeout with

```ruby
response.timed_out?
```

## Web Servers

### unicorn

```ruby
# config/unicorn.rb
timeout 15
```

This kills and respawns the worker process.

It’s recommended to use this in addition to [Rack middleware](#rack-middleware).

### puma

There’s [no timeout option](https://github.com/puma/puma/issues/160). Use [Rack middleware](#rack-middleware) instead.

## Rack Middleware

### rack-timeout

```ruby
Rack::Timeout.timeout = 5
```

Default: 15s

Raises `Rack::Timeout::RequestTimeoutError` or `Rack::Timeout::RequestExpiryError`

[Read more here](https://github.com/heroku/rack-timeout#the-rabbit-hole)

### slowpoke

```ruby
Slowpoke.timeout = 5
```

Default: 15s

Raises same exceptions as [rack-timeout](#rack-timeout)

## External Services

### geocoder

```ruby
Geocoder.configure(timeout: 1, ...)
```

No exception is raised by default. To raise exceptions, use

```ruby
Geocoder.configure(timeout: 1, always_raise: :all, ...)
```

Raises `Timeout::Error`

### twilio-ruby

```ruby
Twilio::REST::Client.new(account_sid, auth_token, timeout: 1)
```

Default: 30s

Raises

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### koala

```ruby
Koala.http_service.http_options = {request: {open_timeout: 1, timeout: 1}}
```

Raises

- `Faraday::ConnectionFailed` on connect timeout
- `Faraday::TimeoutError` on read timeout

### twitter

Not configurable at the moment, and no timeout by default

### stripe

[Master branch only](https://github.com/stripe/stripe-ruby/pull/267)

```ruby
Stripe.open_timeout = 1
Stripe.read_timeout = 1
```

Default: 30s connect timeout, 80s read timeout

Raises `Stripe::APIConnectionError`

### zendesk_api

Not configurable at the moment

Default: 10s connect timeout, no read timeout

### hipchat

```ruby
[HipChat::Client, HipChat::Room, HipChat::User].each { |c| c.default_timeout(1) }
```

Raises

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### firebase

No official support yet, but this does the job

```ruby
firebase = Firebase::Client.new(url)
firebase.request.instance_variable_get(:@client).connect_timeout = 1
firebase.request.instance_variable_get(:@client).receive_timeout = 1
firebase.request.instance_variable_get(:@client).send_timeout = 1
```

Raises

- `HTTPClient::ConnectTimeoutError` on connect timeout
- `HTTPClient::ReceiveTimeoutError` on read timeout

## Don’t see a library you use?

[Let us know](https://github.com/ankane/ruby-timeouts/issues/new). Even better, [create a pull request](https://github.com/ankane/ruby-timeouts/pulls) for it.

## Rescuing Exceptions

Take advantage of inheritance. Instead of

```ruby
rescue Net::OpenTimeout, Net::ReadTimeout
```

you can do

```ruby
rescue Timeout::Error
```

Use

- `Timeout::Error` for both `Net::OpenTimeout` and `Net::ReadTimeout`
- `Faraday::ClientError` for both `Faraday::ConnectionFailed` and `Faraday::TimeoutError`
- `HTTPClient::TimeoutError` for both `HTTPClient::ConnectTimeoutError` and `HTTPClient::ReceiveTimeoutError`
- `Redis::BaseConnectionError` for both `Redis::CannotConnectError` and `Redis::TimeoutError`
- `Rack::Timeout::Error` for both `Rack::Timeout::RequestTimeoutError` and `Rack::Timeout::RequestExpiryError`

## Existing Services

Adding timeouts to existing services can be a daunting task, but there’s a low risk way to do it.

1. Select a timeout - say 5 seconds
2. Log instances exceeding the proposed timeout
3. Fix them
4. Add the timeout
5. Repeat this process with a lower timeout, until your target timeout is achieved

## Running the Tests

```sh
git clone https://github.com/ankane/ruby-timeouts.git
cd ruby-timeouts
bundle install
node test/server.js # in a separate window
rake
```

## Bonus: PostgreSQL Statement Timeouts

Prevent single queries from taking up all of your database’s resources. Set a [statement timeout](http://www.postgresql.org/docs/9.4/static/runtime-config-client.html#GUC-STATEMENT-TIMEOUT) in your `config/database.yml`

```yml
production:
  variables:
    statement_timeout: 250 # ms
```

or set it on your database role

```sql
ALTER ROLE myuser SET statement_timeout = 250;
```

Test statement timeouts with

```sql
SELECT pg_sleep(30);
```

## And lastly...

> Because time is not going to go backwards, I think I better stop now. - Stephen Hawking

:clock4:
