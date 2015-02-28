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
    @movies = Movie.all # restrict to current month at some point?
    erb :upcoming
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

Rottenmovies.run!