class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{user.nickname}"
    end
    redirect_to root_path
  end
end
