class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes

  def self.create_comment! comment_string, current_user, current_movie
    new_comment = Comment.create!(comment: comment_string, user_id: current_user.id, movie_id: current_movie.id)
  end
end