require 'sinatra'
require 'pp'

get '/' do
  erb :index
end

post '/greeting' do
  #puts "params"
  #pp params

  "<p>#{params[:salutation]}, #{params[:name]}</p>"
end
