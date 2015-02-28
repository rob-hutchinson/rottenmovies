require 'minitest/autorun'
<<<<<<< HEAD
require 'rack/test'

# require 'active_record'
require './rottenmovies'

class CommentTest < MiniTest::Test


 include Rack::Test::Methods

  def app
    Rottenmovies
  end

  def test_user_has_comments
    user = User.first
    Comment.create_comment!(comment: "this is my comment", user_id: user.id, movie_id: 200)
    assert_equal user.comments.last.comment, "this is my comment"
  end
  
  def test_movies_have_comments
    user = User.first
    movie = Movie.create!(title: "Asshole")
    Comment.create_comment!(comment: "this is my comment", user_id: user.id, movie_id: movie.id)
    assert_equal movie.comments.last.comment, "this is my comment"
  end
end