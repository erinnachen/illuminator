require "rails_helper"

RSpec.feature "user can get their gem count" do
  include SpecHelpers
  scenario "sees illumination tab with repo count and gems ordered by number of includes" do
    VCR.use_cassette "count_gems" do
      stub_omniauth
      visit '/'
      click_on "Sign in with Github"
      expect(current_path).to eq '/erinnachen'
      click_on "Luminate!"

      expect(current_path).to eq '/erinnachen/illuminate'
      within(".gem-meta") do
        expect(page).to have_content "Total Repos: 41"
        expect(page).to have_content "Repos with a Gemfile: 16"
      end
      within(".gem-list") do
        expect(page).to have_content "rails (9)"
        expect(page).to have_content "minitest (14)"
      end
    end

  end
end
