# Ruby Timeouts

An unresponsive service is worse than a down one. It can tie up your entire system if not handled properly. **All network requests should have a timeout.**

Here’s how to add timeouts for popular Ruby gems. **[All have been tested](test)**. The default is no timeout, unless otherwise specified. Enjoy!

## Gems

Data Stores

- [activerecord](#activerecord)
- [pg](#pg)
- [mysql2](#mysql2)
- [dalli](#dalli)
- [redis](#redis)
- [mongo](#mongo)
- [bunny](#bunny)
- [elasticsearch](#elasticsearch)
- [searchkick](#searchkick)

HTTP Clients

- [net/http](#nethttp)
- [http](#http)
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

Bonus

- [PostgreSQL statement timeouts](#bonus-postgresql-statement-timeouts)

## Data Stores

### activerecord

#### `postgres` adapter

```ruby
ActiveRecord::Base.establish_connection(connect_timeout: 1, ...)
```

or in `config/database.yml`

```yaml
production:
  connect_timeout: 1
```

Raises `PG::ConnectionBad`.

#### `mysql2` adapter

```ruby
ActiveRecord::Base.establish_connection(connect_timeout: 1, read_timeout: 1, write_timeout: 1, ...)
```

or in `config/database.yml`

```yaml
production:
  connect_timeout: 1
  read_timeout: 1
  write_timeout: 1
```

Raises `Mysql2::Error`.

### pg

```ruby
PG.connect(connect_timeout: 1, ...)
```

Raises `PG::ConnectionBad`.

### mysql2

```ruby
Mysql2::Client.new(connect_timeout: 1, read_timeout: 1, write_timeout: 1, ...)
```

Raises `Mysql2::Error`.

### dalli

```ruby
Dalli::Client.new(host, socket_timeout: 1, ...)
```

Default: 0.5s

Raises `Dalli::RingError`.

### redis

```ruby
Redis.new(connect_timeout: 1, timeout: 1, ...)
```

Raises:

- `Redis::CannotConnectError` on connect timeout
- `Redis::TimeoutError` on read timeout

### mongo

```ruby
Mongo::Client.new([host], socket_timeout: 1, server_selection_timeout: 1, ...)
```

Raises `Mongo::Error::NoServerAvailable` on connect timeout.

TODO: read timeout

### bunny

```ruby
Bunny.new(connection_timeout: 1, ...)
```

Raises `Bunny::TCPConnectionFailedForAllHosts` on connect timeout.

TODO: read timeout

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

Raises same exceptions as [elasticsearch](#elasticsearch).

## HTTP Clients

### net/http

```ruby
Net::HTTP.start(host, port, open_timeout: 1, read_timeout: 1) do
  # ...
end
```

Raises:

- `Net::OpenTimeout` on connect timeout
- `Net::ReadTimeout` on read timeout

### http

```ruby
HTTP.timeout(:per_operation, connect: 1, read: 1, write: 1).get(url)
```

Raises `HTTP::TimeoutError`.

### rest-client

```ruby
RestClient::Request.execute(method: :get, url: url, open_timeout: 1, timeout: 1)
```

Raises `RestClient::RequestTimeout`.

### faraday

```ruby
Faraday.get(url) do |req|
  req.options.timeout = 1
  req.options.open_timeout = 1
end
```

Raises:

- `Faraday::ConnectionFailed` on connect timeout
- `Faraday::TimeoutError` on read timeout

### curb

```ruby
curl = Curl::Easy.new(url)
curl.connect_timeout = 1
curl.timeout = 1
curl.perform
```

Raises `Curl::Err::TimeoutError`.

### typhoeus

```ruby
response = Typhoeus.get(url, connecttimeout: 1, timeout: 1)
```

No exception is raised. Check for a timeout with:

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

Raises `Rack::Timeout::RequestTimeoutError` or `Rack::Timeout::RequestExpiryError`.

[Read more here](https://github.com/heroku/rack-timeout#the-rabbit-hole).

### slowpoke

```ruby
Slowpoke.timeout = 5
```

Default: 15s

Raises same exceptions as [rack-timeout](#rack-timeout).

## Don’t see a library you use?

[Let us know](https://github.com/ankane/ruby-timeouts/issues/new). Even better, [create a pull request](https://github.com/ankane/ruby-timeouts/pulls) for it.

## Running the Tests

```sh
git clone https://github.com/ankane/ruby-timeouts.git
cd ruby-timeouts
bundle install
node test/server.js # in a separate window
rake
```

## Bonus: PostgreSQL Statement Timeouts

Prevent single queries from taking up all of your database’s resources. Set a [statement timeout](http://www.postgresql.org/docs/9.4/static/runtime-config-client.html#GUC-STATEMENT-TIMEOUT) in your `config/database.yml`:

```yml
production:
  variables:
    statement_timeout: 250 # ms
```

or set it on your database role:

```sql
ALTER ROLE myuser SET statement_timeout = 250;
```

Test statement timeouts with:

```sql
SELECT pg_sleep(30);
```

## And lastly...

> Because time is not going to go backwards, I think I better stop now. - Stephen Hawking

:clock4:
