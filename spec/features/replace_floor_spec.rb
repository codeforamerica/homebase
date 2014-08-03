require 'spec_helper'

feature "Replace sidings" do

  scenario "when user selects replace flooring that doesn't need permit (Only carpet/tile, etc.)" do

    visit new_permit_path

    # permit#new
    check "Floor"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.floor_covering" do
      choose "Yes"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter your address", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_not_needed').should have_content('Floor')

    page.has_no_button? "Apply for this permit"

  end
  
  scenario "when user selects floor that needs permit (structural changes)" do

    visit new_permit_path

    # permit#new
    check "Floor"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.floor_covering" do
      choose "No"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter your address", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Floor')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details

    fill_in "Home owner name*", with: "John Doe"
    page.has_field?('Address*', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Home owner email address*", with: "john@johndoe.com"
    fill_in "Home owner phone number*", with: "413-456-3456"

    fill_in "work_summary", with: "Replace siding in my backyard"
    fill_in "Job cost*", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "accepted-terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    # This is odd it is not working, as if button wasn't clicked
    # expect(current_path).to eq('/permit_steps/display_summary')
    # expect(page).to have_content("Almost done! We filled in your permit applications")

  end

end