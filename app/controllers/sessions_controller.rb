class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{user.nickname}"
      redirect_to user_path(user.nickname)
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully signed out"
    redirect_to root_path
  end
end
