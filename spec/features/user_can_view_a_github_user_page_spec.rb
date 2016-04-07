require "rails_helper"

RSpec.feature "user can view a github users page" do
  scenario "guest visits a users page" do
    VCR.use_cassette "guest user#show" do
      visit "/erinnachen"

      expect(page).to have_content "erinnachen"
    end
  end
end
