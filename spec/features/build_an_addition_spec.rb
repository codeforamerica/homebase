require 'spec_helper'

feature "Build an addition" do
  scenario "User wants to build an addition" do
    visit "/permits/new"

    check "permit[addition]"
    click_button "Submit"

    expect(page).to have_text("Enter your address")
  end
end