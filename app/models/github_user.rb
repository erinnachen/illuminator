require "json"

class GithubUser
  attr_reader :username, :avatar, :name, :location, :followers, :following

  def initialize(data, access_token)
    @username   = data[:login]
    @avatar     = data[:avatar_url]
    @name       = data[:name]
    @location   = data[:location]
    @followers  = data[:followers]
    @following  = data[:following]
    @_service = UserService.new(access_token)
  end

  def self.service(access_token)
    UserService.new(access_token)
  end

  def self.find(username, access_token)
    github_user_data = service(access_token).user(username)
    GithubUser.new(github_user_data, access_token)
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
