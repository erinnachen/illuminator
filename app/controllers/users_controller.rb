class UsersController < ApplicationController
  def show
    #@user_data = User.find_by(params[:username])
    response = Faraday.get("https://api.github.com/users/#{params[:username]}?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}")
    @user_data = UserData.parse_from_data(response)

    #@orgs = user.orgs
    response = Faraday.get("https://api.github.com/users/#{params[:username]}/orgs?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}")
    @orgs = Org.parse_from_data(response)

    #@repos = user.repos
    response =
    Faraday.get("https://api.github.com/users/#{params[:username]}/repos?per_page=100&client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}")
    @repos = Repo.parse_from_data(response)
    @repos = @repos.sort_by { |repo| Time.now-repo.updated_at }
  end
end
