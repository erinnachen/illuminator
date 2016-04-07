class UserService
  attr_reader :connection

  def initialize(access_token)
    @_connection = Faraday.new(url: "https://api.github.com")
    @_access_token = access_token
    connection.params['access_token'] = access_token
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

  def has_gemfile?(repo)
    response = connection.get do |conn|
      conn.url "/repos/#{repo.owner}/#{repo.name}/contents/Gemfile.lock"
      conn.headers["Accept"] = "application/vnd.github.v3.raw+json"
    end
    response.status == 200
  end

  def get_gems(repo)
    response = connection.get do |conn|
      conn.url "/repos/#{repo.owner}/#{repo.name}/contents/Gemfile.lock"
      conn.headers["Accept"] = "application/vnd.github.v3.raw+json"
    end
    if response.status == 200
      parse_raw_gemfile(response.body)
    end
  end

    private
    def connection
      @_connection
    end

    def access_token
      @_access_token
    end

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

    def parse_raw_gemfile(response_body)
      gemlines = response_body.split("\n")
      end_index = gemlines.index { |line| line == "PLATFORMS" } ||
                  gemlines.index { |line| line == "DEPENDENCIES" }
      gemlines[3..end_index-2].map {|line|
        line.strip.split(" ")[0]
      }.uniq
    end
end
