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

  context "#orgs" do
    it "returns a collection of orgs the user is part of" do
      VCR.use_cassette "githubuser#orgs" do
        user = GithubUser.find("josevalim")
        orgs = user.orgs
        org = orgs.first

        expect(org).to be_kind_of Org
        expect(org.login).to eq "rails"
        expect(org.avatar).to eq "https://avatars.githubusercontent.com/u/4223?v=3"
        expect(org.url).to eq "https://github.com/rails"
        expect(orgs.count).to eq 5
      end
    end
  end

  context "#repos" do
    it "returns a collection of repos the user owns" do
      VCR.use_cassette "githubuser#repos" do
        user = GithubUser.find("erinnachen")
        repos = user.repos
        repo = repos.first

        expect(repo).to be_kind_of Repo
        expect(repo.name).to eq "web_guesser"
        expect(repo.language).to eq "Ruby"
        expect(repo.url).to eq "https://github.com/erinnachen/web_guesser"
        expect(repo.owner.username).to eq "erinnachen"
        expect(repos.count).to eq 41
      end
    end
  end

  context "#starred" do
    it "returns a collection of repos the user starred" do
      VCR.use_cassette "githubuser#starred" do
        user = GithubUser.find("dankogai")
        starred = user.starred
        star = starred.first

        expect(star).to be_kind_of Repo
        expect(star.name).to eq "extract_jawp_names"
        expect(star.language).to eq "Perl"
        expect(star.url).to eq "https://github.com/hiroshi-manabe/extract_jawp_names"
        expect(star.owner.username).to eq "hiroshi-manabe"
        expect(star.starred_at.strftime("%B %-d, %Y")).to eq "March 1, 2016"
        expect(starred.count).to eq 46
        expect(user.starred_count).to eq 46
      end
    end
  end
end
