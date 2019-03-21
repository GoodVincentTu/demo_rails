class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Login Successfully"
      session[:user_id] = user.id
      redirect_to edit_user_path(user.id)
    else
      flash[:error] = "Oops, email/password are not correct"
      redirect_to new_session_path
    end
    
  end
  
  def destroy
    @current_user = nil
    session.delete(:user_id)
    redirect_to new_session_path
  end
end