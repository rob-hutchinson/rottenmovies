class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :upvotes
  has_many :movies, through: :user_movies

  validates :name, presence: true
  validates :email, uniqueness: true

  def add_comment comment_string
    comment = comment_string
    Comment.create!(comment: comment, user_id: self.id)
  end

end


