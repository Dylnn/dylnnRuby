require 'sinatra'

while 1 do 
get '/' do
  p "Hello, world"
  sleep(1)
end
end