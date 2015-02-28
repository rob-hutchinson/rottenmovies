class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :upvotes
  has_many :movies, through: :user_movies

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :username, uniqueness: true

  # def add_comment comment_string
  #   comment = Comment.create! comment: comment_string #, user_id: self.id
  # end

end


