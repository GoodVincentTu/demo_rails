class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    
    if user.save
      session[:user_id] = user.id
      UserMailer.welcome_email(user).deliver_now
      redirect_to edit_user_path(user.id)
    else
      flash[:error] = "Not valid Email or Password format"
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_params)
      flash[:success] = 'Updated successfully'
    else
      flash[:error] = 'Updated fail'
    end
    redirect_to edit_user_path(@user.id)
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
    def update_params
      if not_update_password
        return params.require(:user).permit(:username)
      else
        return params.require(:user).permit(:username, :password, :password_confirmation)
      end
    end
    
    def not_update_password
      return !(params[:user][:password] && 
        params[:user][:password_confirmation] &&
        params[:user][:password] === params[:user][:password_confirmation])
    end 
end