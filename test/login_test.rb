require './test/helper'
require 'rack/test'

require './rottenmovies'

class UserTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    Rottenmovies
  end

  def test_users_can_login
    # We aren't logged in to start with (see a login button)
    create_user!

    get '/'
    assert last_response.body.include? "Login"
    refute last_response.body.include? "Logout"

    # We got to login and can login
    post '/users/login', email: 'brit@kingcons.io', password: 'hunter2'
    assert last_response.redirect?

    # Now we should be logged in (see logout button)
    get '/'
    assert_equal last_response.status, 200
    refute last_response.body.include? "Login"
    assert last_response.body.include? "Logout"
  end

end

