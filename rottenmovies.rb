require 'sinatra/base'
require 'pry'
require 'digest'

require './db/setup'
require './lib/all'


class Rottenmovies < Sinatra::Base
  
  enable :sessions, :method_override
  set :session_secret, ENV.fetch('SESSION_SECRET', 'super_secret')

  # LOGIN_REQUIRED_ROUTES = [
  #   "/comments"
  # ]

  def current_user
    if session[:user_id]
      User.find session[:user_id]
    end
  end

  # LOGIN_REQUIRED_ROUTES.each do |path|
  #   before path do
  #     if current_user.nil?
  #       session[:error_message] = "You must log in to see this feature."
  #       session[:return_trip] = path
  #       redirect to('/users/login')
  #     end
  #   end
  # end


  get '/' do

    erb :upcoming
  end

   get '/users/login' do
    erb :login
  end

  post '/users/login' do
    user = User.where(
      email:    params[:email],
      password: Digest::SHA1.hexdigest(params[:password])
    ).first

    if user
      session[:user_id] = user.id
      if session["return_trip"]
        path = session["return_trip"]
        session.delete("return_trip")
        redirect to(path)
      else
        redirect to('/')
      end
    else
      session[:error_message] = "Invalid credentials. Try again."
      status 422
      erb :login
    end
  end

  delete '/users/logout' do
    session.delete :user_id
    redirect to('/')
  end



  get '/users' do

    erb :profile
  end

  get 'movies' do

    erb :movie
  end

  not_found do
    status 404
    erb :nope
  end

end