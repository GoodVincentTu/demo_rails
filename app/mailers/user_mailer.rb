class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to Incuit"
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: "Reset your password"    
  end
end