class ReposController < ApplicationController
  def star
    repo = Repo.find(id)
    repo.star
    render nothing: true
  end
end
