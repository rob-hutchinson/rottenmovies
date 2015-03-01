# validation.rb
# 3/1/15, 3:31 AM
# Validation on email and password and, to a degreee, user name

class Validation
  attr_reader :email_re :password_re
  def initialize
    # Overkill. Basic is: /.+@.+\..+/i
    @email_re = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    @password_re = /\w{8,}/
  end

  def validate_email email=""
    @email_re.match(email) ? true : false
  end
  
  def validate_password pswd=""
    @password_re.match(pswd) ? true : false
  end
  
end
