require "spec_helper"

describe Repo do
  it "should create with the appropriate fields" do
    repo = Repo.new(repo_data)
    expect(repo.name).to eq "all_the_coins"
    expect(repo.owner.username).to eq "erinnachen"
    expect(repo.language).to eq "Ruby"
    expect(repo.fork_count).to eq 5
    expect(repo.star_count).to eq 8
    expect(repo.description).to eq "A juicy juicy repo"
    expect(repo.updated_at).to be_kind_of DateTime
    expect(repo.starred_at).to be nil
    expect(repo.url).to eq "https://github.com/erinnachen/all_the_coins"
  end

  it "should starred_at field for starred repos" do
    repo = Repo.new(repo_data.merge({starred_at: "2015-04-30T20:15:58Z" }))
    expect(repo.name).to eq "all_the_coins"
    expect(repo.starred_at).to be_kind_of DateTime
  end

  def repo_data
    {name: "all_the_coins",
     owner: {login: "erinnachen", avatar_url: "https://avatars.githubusercontent.com/u/12789537?v=3", name: "Erinna Chen", location: "Denver, CO", followers: 25, following: 33},
     language: "Ruby",
     forks_count: 5,
     stargazers_count: 8,
     description: "A juicy juicy repo",
     fork: false,
     updated_at: "2014-04-25T20:15:58Z",
     html_url: "https://github.com/erinnachen/all_the_coins"}
  end
end
