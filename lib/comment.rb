class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes

  def self.create_comment! comment, current_user, current_movie
    new_comment = Comment.create!(comment: comment, user_id: current_user.id, movie_id: current_movie.id)
  end

  def edit_comment new_comment
    if new_comment != self.comment
      self.update! comment: new_comment
    end
  end
end