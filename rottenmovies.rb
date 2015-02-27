require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'


class Rottenmovies < Sinatra::Base
  
  def current_user
    u = User.first
  end

  get '/' do

    erb :upcoming
  end

  get '/users' do

    erb :profile
  end

  get '/movies' do
    erb :movie
  end

  post '/movies' do
     current_user.add_comment params["comment_string"]
    erb :movie
  end

  not_found do
    status 404
    erb :nope
  end

end

Rottenmovies.run!