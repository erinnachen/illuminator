require "json"

class GithubUser
  attr_reader :username, :avatar, :name, :location, :followers, :following
  def self.service
    UserService.new
  end

  def initialize(params)
    @username   = params[:username]
    @avatar     = params[:avatar]
    @name       = params[:name]
    @location   = params[:location]
    @followers  = params[:followers]
    @following  = params[:following]
  end

  def self.build_user(data)
    parsed = {}
    parsed[:username]   = data.login
    parsed[:avatar]     = data.avatar_url
    parsed[:name]       = data.name
    parsed[:location]   = data.location
    parsed[:followers]  = data.followers
    parsed[:following]  = data.following
    GithubUser.new(parsed)
  end

  def self.find(username)
    github_user_data = service.user(username)
    build_user(github_user_data)
  end

  def orgs
    Org.parse_from_data(GithubUser.service.orgs(username))
  end

  def repos
    repos = Repo.parse_from_data(GithubUser.service.repos(username))
    repos.sort_by { |repo| Time.now - repo.updated_at }
  end

  def starred
    starred = Repo.parse_from_data(GithubUser.service.starred(username), true)
    starred.sort_by { |repo| Time.now - repo.starred_at }
  end

  def starred_count
    starred.count
  end
end
