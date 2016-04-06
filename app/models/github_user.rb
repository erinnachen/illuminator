require "json"

class GithubUser
  attr_reader :username, :avatar, :name, :location, :followers, :following

  def self.service
    UserService.new
  end

  def initialize(data)
    @username   = data[:login]
    @avatar     = data[:avatar_url]
    @name       = data[:name]
    @location   = data[:location]
    @followers  = data[:followers]
    @following  = data[:following]
  end

  def self.find(username)
    github_user_data = service.user(username)
    GithubUser.new(github_user_data)
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
