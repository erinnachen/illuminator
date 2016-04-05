class Repo
  attr_reader :name, :updated_at, :description, :star_count, :fork_count, :language
  def initialize(data)
    @name                 = data.name
    @language             = data.language
    @fork_count           = data.forks_count
    @star_count           = data.stargazers_count
    @description          = data.description
    @fork                 = data.fork
    @updated_at           = DateTime.parse(data.updated_at)
  end

  def self.parse_from_data(response)
    data = JSON.parse(response.body, object_class: OpenStruct)
    data.map do |repo_data|
      Repo.new(repo_data)
    end
  end
end
