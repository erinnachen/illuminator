class UserService
  attr_reader :connection

  def initialize(user = nil)
    @_connection = Faraday.new(url: "https://api.github.com")
    connection.params['client_id']     = ENV['github_client_id']
    connection.params['client_secret'] = ENV['github_client_secret']
  end

  def get(path, page = nil)
    params = {page: page} if page
    connection.get(path, params)
  end

  def get_starred(path, page = nil)
    connection.get do |conn|
      conn.url path
      conn.headers["Accept"] = "application/vnd.github.v3.star+json"
      conn.params["page"] = page if page
    end
  end

  def user(username)
    parse_response(get("/users/#{username}"))
  end

  def repos(username)
    repos = []
    response = get("/users/#{username}/repos")
    repos << parse_response(response)
    if get_more_pages?(response.headers)
      (2..max_page(response.headers[:link])).each do |n|
        response = get("/users/#{username}/repos", n)
        repos << parse_response(response)
      end
    end
    repos.flatten
  end

  def orgs(username)
    parse_response(get("/users/#{username}/orgs"))
  end

  def starred(username)
    starred = []
    response = get_starred("/users/#{username}/starred")
    starred_data = parse_response(response)
    repos_data = merge_starred_at(starred_data)
    starred << repos_data
    if get_more_pages?(response.headers)
      (2..max_page(response.headers[:link])).each do |n|
        response = get_starred("/users/#{username}/starred", n)
        starred_data = parse_response(response)
        repos_data = merge_starred_at(starred_data)
        starred << repos_data
      end
    end
    starred.flatten
  end


    def connection
      @_connection
    end

    private
    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_more_pages?(headers)
      !!headers[:link]
    end

    def max_page(link_header)
      link_header.split(/;|,/)[-2][-2].to_i
    end

    def merge_starred_at(starred_data)
      starred_data.map {|star_data|
        repo = star_data[:repo]
        repo[:starred_at] = star_data[:starred_at]
        repo
      }
    end
end
