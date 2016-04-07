require "rails_helper"

RSpec.feature "require login to view a github users page" do
  scenario "guest visits a users page" do
    VCR.use_cassette "guest user#show" do
      visit "/erinnachen"
      expect(current_path).to eq "/"
      expect(page).not_to have_content "erinnachen"
    end
  end
end
