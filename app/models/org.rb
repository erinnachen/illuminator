class Org
  attr_reader :login, :avatar, :url
  def initialize(data)
    @login = data.login
    @avatar = data.avatar_url
    @url = "https://github.com/#{data.login}"
  end

  def self.parse_from_data(data)
    data.map do |org_data|
      Org.new(org_data)
    end
  end
end
