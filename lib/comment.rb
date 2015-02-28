class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes

end