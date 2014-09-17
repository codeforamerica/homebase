require 'spec_helper'

feature "Build a cover" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a carport, patio cover, or porch cover that needs permit" do

    visit '/permits'

    # permit#new
    check "Carport or Outdoor Cover"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Carport/Outdoor Cover')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Name", with: "John Doe"
    page.has_field?('Street address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Email address", with: "john@johndoe.com"
    fill_in "Phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Building an addition in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content("Read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content("Congrats! You filled out your permit application")
    expect(page).to have_content("Make a detailed site plan")

  end

  after(:all) do
    @cosa.destroy
  end
end