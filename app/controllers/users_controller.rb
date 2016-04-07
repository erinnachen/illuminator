class UsersController < ApplicationController
  def show
    @github_user = GithubUser.find(params[:username])
  end

end
