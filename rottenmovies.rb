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

   # This is just for testing:
  def current_movie
    m = Movie.last
    return m
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

   get '/users/login' do
    erb :login
  end

  get '/' do
    # Movie.generate_upcoming_movie_list! 
    # comment out if you need to generate a movie list.
    @movies = Movie.all.order(release_date: :desc, title: :asc) # restrict to current month at some point?
    erb :upcoming
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
      redirect to('/')
      # end
    else
      session[:error_message] = "Nope. Try again."
      status 422
      erb :login
    end
  end

  delete '/users/logout' do
    session.delete :user_id
    redirect to('/')
  end
  
  get '/create_account' do
    erb :create_account
  end

  post '/create_account' do
    begin
      if User.find_by(username: params["username"]) || User.find_by(email: params["email"])
        session[:error_message] = "User already exists."
      else
        user = User.create!(name: params["name"], username: params["username"], email: params["email"], password: Digest::SHA1.hexdigest(params[:password]))
        session[:success_message] = "User account for #{user.name} created successfully. Account ID is #{user.id}."
      end
      rescue
        session[:error_message] = "User creation failed. Please try again."
      ensure
        redirect '/create_account'
    end
  end

  get '/users' do
    erb :profile
  end

  get '/movies' do
    erb :movie
  end

  get '/movies/:rotten_id' do
    @movie = Movie.find_by(rotten_id: params[:rotten_id])
    if @movie
      @comments = Comment.where(movie_id: @movie.id)
      erb :movie_page
    else
      erb :nope
    end
  end

  post '/movies' do
    new_comment = Comment.create_comment!(params["comment_string"], current_user, current_movie)
    erb :movie
  end

  not_found do
    status 404
    erb :nope
  end

end


Rottenmovies.run! if $PROGRAM_NAME == __FILE__

