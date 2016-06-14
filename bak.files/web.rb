require 'rubygems'
require 'sinatra'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require "thread"
require 'pp'
#encoding=utf-8

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : '岩土工程'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end


#get '/' do
#  @agent = Mechanize.new
#  (1..10).each do |i|
 # p 'heheda'
#  end
#  erb 'Can you handle a <a href="/secure/place">secret</a>?'
#end

get '/' do
  erb :index
end

get '/login/form' do
@agent = Mechanize.new
  erb :login_form
end

post '/login/attempt' do
@agent = Mechanize.new
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
@agent = Mechanize.new
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end

post '/greeting' do
  #puts "params"
  #pp params
  params[:time] = Time.now
  "<p>#{params[:salutation]}, #{params[:name]} 现在时间是：#{params[:time]} </p>"
  "<p>#{params[:salutation]}, #{params[:name]} 现在时间是：#{params[:time]} </p>"
end
