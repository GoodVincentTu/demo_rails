class PasswordsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_token_expiration, only: [:edit, :update]
  before_action :validate_token, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password][:email])
    if @user
      @user.create_reset_password_token
      UserMailer.reset_password(@user).deliver_now
      flash[:success] = 'Reset password email has successfully sent.'
      redirect_to root_url
    else
      flash[:error] = "User not exists"
      redirect_to new_password_path
    end
  end

  def edit; end
  
  def update
    if @user.update_attributes(user_params)
      @user.update_attributes(reset_token_digest: nil)
      flash[:success] = "Password has been updated."
      redirect_to edit_user_path(@user.id)
    else
      redirect_to edit_password_path(@user.email)
    end 
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    def get_user
      @user = User.find(params[:id])
    end
    
    def check_token_expiration
      if @user.reset_token_expired?
        flash[:error] = "Password reset link has expired."
        redirect_to new_password_path
      end
    end 

    def validate_token
      BCrypt::Password.new(@user.reset_token_digest).is_password?(params[:reset_password_token])
    end
    
end