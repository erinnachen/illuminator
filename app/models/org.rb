class Org
  attr_reader :login, :avatar, :url
  def initialize(data)
    @login = data[:login]
    @avatar = data[:avatar_url]
    @url = "https://github.com/#{data[:login]}"
  end
end
