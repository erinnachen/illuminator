class Repo
  attr_reader :name
  def initialize(data)
    @name = data.name
  end

  def self.parse_from_data(response)
    data = JSON.parse(response.body, object_class: OpenStruct)
    binding.pry
    data.map do |repo_data|
      Repo.new(repo_data)
    end
  end
end
