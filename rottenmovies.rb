require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'


class Rottenmovies < Sinatra::Base
  
  def current_user
    u = User.first
    return u
  end

  # This is just for testing:
  def current_movie
    m = Movie.last
    return m
  end

  get '/' do
    # Movie.generate_upcoming_movie_list! 
    # comment out if you need to generate a movie list.
    @movies = Movie.all.order(release_date: :desc, title: :asc) # restrict to current month at some point?
    erb :upcoming
  end

  get '/users' do

    erb :profile
  end

  get '/movies' do
    erb :movie
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

Rottenmovies.run!