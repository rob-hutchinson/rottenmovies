class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :upvotes
  has_many :movies, through: :user_movies

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :username, uniqueness: true
  validates :location, length: { maximum: 20 }

  def defaults
    self.location ||= "The Iron Yard, D.C."
    self.bio ||= "Member of The IronYard D.C. branch."
  end

end