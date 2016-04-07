class ReposController < ApplicationController
  before_action :require_user
  def star
    repo = Repo.find(id)
    repo.star
    render nothing: true
  end
end
