class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes

  def self.create_comment! comment_string, current_user, current_movie
    new_comment = Comment.create!(comment: comment_string, user_id: current_user.id, movie_id: current_movie.id)
  end

  def upvote! current_user
    unless current_user.upvotes != []
      current_user.upvotes << (Upvote.create! comment_id: self.id, user_id: current_user.id)
    end
  end

end