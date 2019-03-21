require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get sign up page' do
    get new_user_path
    assert_template 'users/new'
  end

  test 'should create new user' do
    assert_difference "User.count", 1 do
      post users_path, params: {
        user: {
          email: 'hello@example.com',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }
    end
  end

  test 'should get edit page' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    get edit_user_path(user.id)
    assert_template 'users/edit'
  end

  test 'should update profile correctly' do
    user = User.create(
      email: 'hello@example.com',
      password: 'Password',
      password_confirmation: 'Password'
    )
    patch user_path(user.id), params: {
      user: {
        username: 'vincenttu'
      }
    }
    user.reload
    assert_equal 'vincenttu', user.username
  end  
end