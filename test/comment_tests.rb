require './test/helper'
require 'rack/test'
require './rottenmovies'

class CommentTest < MiniTest::Test


 include Rack::Test::Methods

  def app
    Rottenmovies
  end

  def test_user_has_comments
    create_user!
    user = User.first
    movie = Movie.create!(title: "goodmovie")
    Comment.create_comment!("this is my comment", user, movie)
    assert_equal user.comments.last.comment, "this is my comment"
  end
  
  def test_movies_have_comments
    create_user!
    user = User.first
    movie = Movie.create!(title: "Asshole")
    Comment.create_comment!("this is my comment", user, movie)
    assert_equal movie.comments.last.comment, "this is my comment"
  end
end