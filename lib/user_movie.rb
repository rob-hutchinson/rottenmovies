class User_Movie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
end