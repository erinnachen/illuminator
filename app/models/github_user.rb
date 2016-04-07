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

  def gemfile_count
    repos.reduce(0) do |count, repo|
      count + add_to_count(repo.has_gemfile?(service))
    end
  end

  def gems
    gem_count = Hash.new(0)
    repos.each do |repo|
      gems = repo.get_gems(service)
      add_gems_to_count(gem_count, gems) if gems
    end
    gem_count.sort_by { |_gemname, count| -1*count }
  end

  private

    def service
      @_service
    end

    def add_to_count(contains_gemfile)
      return 1 if contains_gemfile
      0
    end

    def add_gems_to_count(gem_count, gemmmas)
      gemmmas.each do |gemmma|
        gem_count[gemmma] += 1
      end
    end
end
