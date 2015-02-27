class Movie < ActiveRecord::Base
  has_many :users, through: :user_movie
  has_many :comments
end