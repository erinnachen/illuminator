require "json"

class UserData
  attr_reader :username, :avatar, :name, :location, :followers, :following
  def initialize(params)
    @username   = params[:username]
    @avatar     = params[:avatar]
    @name       = params[:name]
    @location   = params[:location]
    @followers  = params[:followers]
    @following  = params[:following]
  end

  def self.parse_from_data(response)
    parsed = {}
    data = JSON.parse(response.body, object_class: OpenStruct)
    parsed[:username]   = data.login
    parsed[:avatar]     = data.avatar_url
    parsed[:name]       = data.name
    parsed[:location]   = data.location
    parsed[:followers]  = data.followers
    parsed[:following]  = data.following
    UserData.new(parsed)
  end
end
