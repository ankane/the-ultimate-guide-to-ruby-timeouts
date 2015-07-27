require "sinatra"

get "/" do
  sleep(2)
  "boom"
end
