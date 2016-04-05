require "rails_helper"

RSpec.feature "user logs in with oauth" do
  include SpecHelpers
  scenario "logs in and sees avatar and dropdown" do
    stub_omniauth
    visit "/"
    click_link "Sign in with Github"

    expect(current_path).to eq "/"
    expect(page).to have_css('img[alt="@worace"]')
    expect(page).to have_css('img[src="https://avatars1.githubusercontent.com/u/1227440"]')
    expect(page).to have_content("Signed in as worace")
    expect(page).to have_link "Sign out"
  end
end
