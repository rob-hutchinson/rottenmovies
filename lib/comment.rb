class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes
  
  after_initialize :defaults

  def defaults
    self.votes ||= 0
  end


  def edit_comment new_comment
    if new_comment != self.comment
      self.update! comment: new_comment
    end
  end

end