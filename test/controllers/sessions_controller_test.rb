require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get login page' do
    get new_session_path 
    assert_template 'sessions/new'
  end

  test 'should login successfully' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    post sessions_path, params: {
      session: {
        email: 'hello@example.com',
        password: 'Password'
      }
    }

    assert_redirected_to edit_user_path(user.id)
  end

  test 'should log out the user' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    post sessions_path, params: {
      session: {
        email: 'hello@example.com',
        password: 'Password'
      }
    }
    delete session_path(user.id)
    assert_redirected_to new_session_path
  end
end