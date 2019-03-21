require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'view signup path' do
    get new_user_path
    assert_template 'users/new'
  end

  test 'sign up an user and sent an welcome email' do
    get new_user_path
    assert_difference "User.count", 1 do
      post users_path, params: {
        user: {
          email: 'hello@example.com',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end