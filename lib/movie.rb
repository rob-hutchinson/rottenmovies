require 'httparty'

require 'dotenv'
Dotenv.load

require 'pry'

class Movie < ActiveRecord::Base
  has_many :users, through: :user_movie
  has_many :comments

  include HTTParty
  format :json
  
  ROTTEN_KEY = ENV.fetch("ROTTEN_KEY")

  # will only create movie if it does not already exist in system.
  # Retrieves upcoming movies to a max of 16 by default
  def self.generate_upcoming_movie_list!
    m = JSON.parse(HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=#{ROTTEN_KEY}"))

    count = 0
    total_movies = m["total"]

    total_movies.times do
      movie_exists = Movie.find_by(rotten_id: m["movies"][count]["id"]) || nil
      if movie_exists
        Movie.create!(
          title: m["movies"][count]["title"],
          thumbnail: m["movies"][count]["posters"]["thumbnail"],
          release_date: m["movies"][count]["release_dates"]["theater"],
          synopsis: m["movies"][count]["synopsis"],
          rotten_id: m["movies"][count]["id"]
        )
      end
      count += 1  
    end

  end

end