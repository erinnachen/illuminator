class Org
  attr_reader :login, :avatar, :url
  def initialize(data)
    @login = data.logina
    @avatar = data.avatar_url
    @url = "https://github.com/#{data.login}"
  end

  def self.parse_from_data(response)
    data = JSON.parse(response.body, object_class: OpenStruct)
    data.map do |org_data|
      Org.new(org_data)
    end
  end
end
