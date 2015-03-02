class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :upvotes
  
  after_initialize :defaults

  def defaults
    self.votes ||= 0
  end

end