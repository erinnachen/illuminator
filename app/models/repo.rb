class Repo
  attr_reader :name, :updated_at, :description, :star_count, :fork_count, :language, :starred_at, :url, :id
  def initialize(data, starred_at = nil)
    @id                   = data.id
    @name                 = data.name
    @language             = data.language
    @fork_count           = data.forks_count
    @star_count           = data.stargazers_count
    @description          = data.description
    @fork                 = data.fork
    @updated_at           = DateTime.parse(data.updated_at)
    @starred_at           = DateTime.parse(starred_at) if starred_at
    @url                  = data.html_url
  end

  def self.parse_from_data(data, starred = false)
    data.map do |repo_data|
      if starred
        Repo.new(repo_data.repo, repo_data.starred_at)
      else
        Repo.new(repo_data)
      end
    end
  end

  def self.find(owner, name)
    self.parse_from_data(UserService.get_repo("/repos/#{owner}/#{name}"))
  end

  def star
    path = "/user/starred/#{owner}/#{name}"
    UserService.star_repo(self)
  end
end
