require "rails_helper"

RSpec.feature "user logsout" do
  include SpecHelpers
  scenario "logs in and sees avatar and dropdown" do
    VCR.use_cassette "user#login" do
      stub_omniauth
      visit "/"
      click_link "Sign in with Github"
      expect(page).to have_content("Signed in as erinnachen")
      expect(page).to have_css('img[alt="@erinnachen"]')

      click_link "Sign out"

      expect(current_path).to eq "/"
      expect(page).to_not have_css('img[alt="@erinnachen"]')
      expect(page).to_not have_css('img[src="https://avatars1.githubusercontent.com/u/12789537"]')
      expect(page).to_not have_content("Signed in as erinnachen")
      expect(page).to have_content("Successfully signed out")
      expect(page).to have_content("Sign in with Github")
    end
  end
end
