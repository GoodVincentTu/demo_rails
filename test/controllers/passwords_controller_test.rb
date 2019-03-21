require 'test_helper'

class PasswrodsControllerTest < ActionDispatch::IntegrationTest
  test 'should get forgot password page' do
    get new_password_path 
    assert_template 'passwords/new'
  end

  test 'should send instruction mail to user' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    post passwords_path, params: {
      password: {email: 'hello@example.com'}
    }
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test 'should get the edit page from the link in the instruction mail' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    user.create_reset_password_token
    user.reload
    get edit_password_url(user, reset_password_token: user.reset_token)
    assert_template 'passwords/edit'
  end

  test 'should update the passwords successfully from the edit page' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    user.create_reset_password_token
    get edit_password_url(user, reset_password_token: user.reset_token)
    patch password_path(user, reset_password_token: user.reset_token), params: {
      user: {
        password: 'Password123',
        password_confirmation: 'Password123'
      }
    }
    assert_redirected_to edit_user_path(user.id)
  end
end