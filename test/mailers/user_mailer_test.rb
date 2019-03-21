require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome email' do
    user = User.create(email: 'hello@example.com',
      password: 'Passwod', password_confirmation: 'Passwod')
    mail = UserMailer.welcome_email(user)
    assert_equal "Welcome to Incuit", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['incuit@example.com'], mail.from
  end
end