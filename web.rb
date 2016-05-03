require 'sinatra'

get '/' do
while(1)
  p ”Hello, world"
  sleep(1)
end
end