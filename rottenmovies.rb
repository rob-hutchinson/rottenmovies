require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'


class Rottenmovies < Sinatra::Base
  
  get '/' do
    @movies = Movie.all # restrict to current month at some point?
    erb :upcoming
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

Rottenmovies.run!