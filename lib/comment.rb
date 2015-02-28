class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes

  def edit_comment new_comment
    if new_comment != self.comment
      self.update! comment: new_comment
    end
  end

  def upvote! current_user
    unless current_user.upvotes != []
      current_user.upvotes << (Upvote.create! comment_id: self.id, user_id: current_user.id)
    end
  end

end