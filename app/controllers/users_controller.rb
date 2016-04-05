class UsersController < ApplicationController
  def show
    @username = params[:username] || "Guest"
  end
end
