class UsersController < ApplicationController
  def show
    @username = params[:username]
  end
end
