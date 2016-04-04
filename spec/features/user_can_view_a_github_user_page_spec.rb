require "rails_helper"

RSpec.feature "user can view a github users page" do
  scenario "guest visits a users page" do
    visit "/erinnachen"

    expect(page).to have_content "erinnachen"
  end
end
