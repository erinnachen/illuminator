class UsersController < ApplicationController
  def show
    response = Faraday.get("https://api.github.com/users/#{params[:username]}?client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}")
    @user_data = UserData.parse_from_data(response)
  end
end
