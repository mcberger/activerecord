require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'

require './models.rb'

enable :sessions
use Rack::Flash, :sweep => true 

set :database, "sqlite3:datapro.sqlite3"

get '/problem' do
	erb "Sorry."
end

get '/logged-in' do
	erb "Welcome user!"
end

get '/sign-in' do
	erb :sign_in
end

post '/sign-in' do
	puts "my params are" + params.inspect
	user = User.where(username: params[:username]).first
	if user && user.password == params[:password]
		session[:user_id] = user.id
		flash[:notice] = "You've been signed in successfully."
		redirect "/logged-in"
	else
		flash[:alert] = "There was a problem signing you in."
	end
	redirect "/problem"
end

get '/signup' do
	erb :signup
end

post '/signup' do
	User.create(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
	
	redirect "/sign-in"
end


if params[:username] == User.where(username:)
	flash[:notice] = "Username is already taken."
	redirect "/signup"
else 
	User.create(fname: params[:fname], lname: params[:lname], username: params[:username], email: params[:email], password: params[:password])
end


