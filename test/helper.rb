require 'minitest/autorun'
require 'pry'

ENV['TEST'] = 'true'
require './db/setup'
require './lib/all'

class MiniTest::Test
  def setup
    [User, Comment, Upvote].each { |klass| klass.delete_all }
  end

  def create_user! attrs={}
    attrs[:email]    ||= 'brit@kingcons.io'
    attrs[:password] ||= 'hunter2'
    attrs[:name]     ||= 'Brit Butler'
    attrs[:password] = Digest::SHA1.hexdigest attrs[:password]
    User.create! attrs
  end
end