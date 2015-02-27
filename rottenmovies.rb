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
      # if session["return_trip"]
      #   path = session["return_trip"]
      #   session.delete("return_trip")
      #   redirect to(path)
      # else
      #   redirect to('/')
      # end
    else
      session[:error_message] = "Wrong. Try again."
      status 422
      erb :login
    end
  end

  delete '/users/logout' do
    session.delete :user_id
    redirect to('/')
  end

  post '/create_account' do
    # ensure_admin!
    # raise "This doesn't work ... we mail the encrypted passwords"
    begin
      x = User.create!(name: params["name"], email: params["email"], password: Digest::SHA1.hexdigest(params[:password]))
      session[:success_message] = "User account for #{x.name} created successfully. Account ID is #{x.id}."
    rescue
      session[:error_message] = "User creation failed. Please try again."
    ensure
      redirect '/create_account'
    end
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

Rottenmovies.run! if $PROGRAM_NAME == __FILE__