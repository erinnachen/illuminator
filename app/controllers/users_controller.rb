class UsersController < ApplicationController
  def show
    @github_user = GithubUser.find(params[:username])
    # @orgs = @github_user.orgs
    @repos = @github_user.repos
  end

  def create
    #send an API call
  end
end
