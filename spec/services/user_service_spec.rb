require "rails_helper"

describe UserService do
  context "#user(username)" do
    it "returns information about a user" do
      VCR.use_cassette("user_service#user") do
        service = UserService.new
        user = service.user("erinnachen")

        expect(user[:login]).to eq "erinnachen"
        expect(user[:name]).to eq "Erinna Chen"
        expect(user[:followers]).to eq 11
      end
    end
  end

  context "#orgs(username)" do
    it "returns the organizations the user belongs to" do
      VCR.use_cassette("user_service#orgs") do
        service = UserService.new
        orgs = service.orgs("josevalim")
        org = orgs.first
        expect(org[:login]).to eq "rails"
        expect(orgs.count).to eq 5
      end
    end
  end

  context "#starred(username)" do
    it "returns the repositories the user starred" do
      VCR.use_cassette("user_service#starred") do
        service = UserService.new
        starred = service.starred("josevalim")
        star = starred.first

        expect(star[:repo][:name]).to eq "hex"
        expect(star[:starred_at]).to eq "2014-04-25T20:15:58Z"
        expect(star[:repo][:html_url]).to eq "https://github.com/hexpm/hex"
        expect(star[:repo][:fork]).to eq false
        expect(starred.count).to eq 221
      end
    end
  end

  context "#repos(username)" do
    it "returns the repositories of the user" do
      VCR.use_cassette("user_service#repos") do
        service = UserService.new
        repos = service.repos("erinnachen")
        repo = repos.first

        expect(repo[:name]).to eq "all_the_coins"
        expect(repo[:html_url]).to eq "https://github.com/erinnachen/all_the_coins"
        expect(repo[:fork]).to eq false
        expect(repos.count).to eq 41
      end
    end
  end
end
