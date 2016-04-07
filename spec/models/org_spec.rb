require "spec_helper"

describe Org do
  it "should create with the appropriate fields" do
    org = Org.new(data)
    expect(org.login).to eq "turingschool"
    expect(org.avatar).to eq "https://avatars.githubusercontent.com/u/7934292?v=3"
  end

  def data
    { login: "turingschool", avatar_url: "https://avatars.githubusercontent.com/u/7934292?v=3"}
  end
end
