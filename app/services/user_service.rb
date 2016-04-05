class UserService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.github.com/users")
    @auth = {client_id: ENV['github_client_id'],
             client_secret: ENV['github_client_secret']}
  end

  def get(path)
    @connection.get(path, @auth)
  end

  def user(username)
    parse_response(get("/users/#{username}"))
  end

  def repos(username)
    parse_response(get("/users/#{username}/repos"))
  end

  def orgs(username)
    parse_response(get("/users/#{username}/orgs"))
  end

  private
    def parse_response(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end
end
