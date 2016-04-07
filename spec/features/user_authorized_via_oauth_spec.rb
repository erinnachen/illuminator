require "rails_helper"

RSpec.feature "user logs in with oauth" do
  include SpecHelpers
  scenario "logs in and sees avatar and dropdown" do
    VCR.use_cassette "user#login" do
      stub_omniauth
      visit "/"
      click_link "Sign in with Github"

      expect(current_path).to eq "/erinnachen"
      expect(page).to have_css('img[alt="@erinnachen"]')
      expect(page).to have_css('img[src="https://avatars1.githubusercontent.com/u/12789537"]')
      expect(page).to have_content("Signed in as erinnachen")
      expect(page).to have_link "Sign out"
      expect(page).to have_content("Repositories")
      expect(page).to have_content("Starred")
      expect(page).to have_link("all_the_coins")
      expect(page).to_not have_button("Follow")
    end
  end
end
