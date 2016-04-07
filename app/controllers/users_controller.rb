class UsersController < ApplicationController
  before_action :require_user
  def show
    @github_user = GithubUser.find(params[:username], current_user.oauth_token)
  end

  def illuminate
    @github_user = GithubUser.find(params[:username], current_user.oauth_token)
  end
end
