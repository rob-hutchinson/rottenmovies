require './test/helper'
require 'rack/test'
require './rottenmovies'

class UpvoteTest < MiniTest::Test


 include Rack::Test::Methods

  def app
    Rottenmovies
  end

  def test_user_can_upvote
    create_user!
    user = User.first
    movie = Movie.create! title: "goodmovie"
    c = Comment.create_comment!("this is my comment", user, movie)
    c.upvote! user

    assert_equal user.upvotes.first.comment_id, c.id

    assert_equal c.upvotes.first.comment_id, c.id
  end

  def test_user_cant_upvote_same_comment_twice
    user = create_user!
    movie = Movie.create! title: "goodmovie"
    c = Comment.create_comment!("good comment", user, movie)
    c.upvote! user
    assert_equal user.upvotes.first.comment_id, c.id

    c.upvote! user
    refute user.upvotes.count > 1
  end

end