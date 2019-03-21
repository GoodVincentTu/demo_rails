require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: 'demo@example.com', password: 'Password',
      password_confirmation: 'Password')
  end
  
  test 'email should not pass the format' do
    @user.email = 'demo'
    assert_not @user.valid?
  end

  test 'email should fit the format' do
    @user.email = 'demo@example.com'
    assert @user.valid?
  end

  test 'password should not pass the length validation' do
    @user.password = @user.password_confirmation = 'hello'
    assert_not @user.valid?
  end

  test 'password should pass the minimum validation' do
    @user.password = @user.password_confirmation = 'helloworld'
    assert @user.valid?
  end
end