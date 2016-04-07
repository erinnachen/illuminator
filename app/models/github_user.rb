require "json"

class GithubUser
  attr_reader :username, :avatar, :name, :location, :followers, :following

  def initialize(data)
    @username   = data[:login]
    @avatar     = data[:avatar_url]
    @name       = data[:name]
    @location   = data[:location]
    @followers  = data[:followers]
    @following  = data[:following]
    @_service = UserService.new
  end

  def self.service
    UserService.new
  end

  def self.find(username)
    github_user_data = service.user(username)
    GithubUser.new(github_user_data)
  end

  def orgs
    service.orgs(username).map {|org_data|
      Org.new(org_data)
    }
  end

  def repos
    service.repos(username).map { |repo_data|
      Repo.new(repo_data)
    }.sort_by { |repo| Time.now - repo.updated_at }
  end

  def starred
    service.starred(username).map { |repo_data|
      Repo.new(repo_data)
    }.sort_by { |repo| Time.now - repo.starred_at }
  end

  def starred_count
    starred.count
  end

  private

    def service
      @_service
    end
end
