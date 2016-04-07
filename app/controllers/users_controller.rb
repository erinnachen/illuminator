class UsersController < ApplicationController
  def show
    @github_user = GithubUser.find(params[:username])
    # if starred?
    #   @repos = @github_user.starred
    # else
    #   @repos = @github_user.repos
    # end
  end


  private
    def starred?
      params[:tab] == "starred" || request.fullpath.include?("/starred")
    end
end
