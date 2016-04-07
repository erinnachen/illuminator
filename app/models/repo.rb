class Repo
  attr_reader :name, :owner, :updated_at, :description, :star_count, :fork_count, :language, :starred_at, :url
  def initialize(data)
    @name                 = data[:name]
    @owner                = GithubUser.new(data[:owner])
    @language             = data[:language]
    @fork_count           = data[:forks_count]
    @star_count           = data[:stargazers_count]
    @description          = data[:description]
    @fork                 = data[:fork]
    @updated_at           = DateTime.parse(data[:updated_at])
    @starred_at           = DateTime.parse(data[:starred_at]) if data[:starred_at]
    @url                  = data[:html_url]
  end
end
