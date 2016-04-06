require "rails_helper"

describe GithubUser do
  context ".find(username)" do
    it "returns a github user" do
      VCR.use_cassette "githubuser.find" do
        user = GithubUser.find("erinnachen")

        expect(user).to be_kind_of GithubUser
        expect(user.name).to eq "Erinna Chen"
        expect(user.username).to eq "erinnachen"
        expect(user.avatar).to eq "https://avatars.githubusercontent.com/u/12789537?v=3"
      end
    end
  end
end
