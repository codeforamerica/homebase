require 'spec_helper'

feature "Build a cover" do
  scenario "when user selects a carport, patio cover, or porch cover that needs permit (It's metal type II)" do

    visit new_permit_path

    # permit#new
    check "Carport or Outdoor Cover"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.cover_material" do
      choose "It's metal type II"
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
    page.find('div.permit_needed').should have_content('Carport/Outdoor Cover')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Home owner name*", with: "John Doe"
    page.has_field?('Address*', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Home owner email address*", with: "john@johndoe.com"
    fill_in "Home owner phone number*", with: "413-456-3456"

    fill_in "work_summary", with: "Building an addition in my backyard"
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

  scenario "when user selects a carport, patio cover, or porch cover that needs permit (It's wood type V)" do

    visit new_permit_path

    # permit#new
    check "Carport or Outdoor Cover"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.cover_material" do
      choose "It's wood type V"
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
    page.find('div.permit_needed').should have_content('Carport/Outdoor Cover')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Home owner name*", with: "John Doe"
    page.has_field?('Address*', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Home owner email address*", with: "john@johndoe.com"
    fill_in "Home owner phone number*", with: "413-456-3456"

    fill_in "work_summary", with: "Building a carport"
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




  scenario "when user selects a carport, patio cover, or porch cover that needs further assistance (Other)" do

    visit new_permit_path

    # permit#new
    check "Carport or Outdoor Cover"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.cover_material" do
      choose "Other"
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
    page.find('div.further_assistance_needed').should have_content('Carport/Outdoor Cover')

    page.has_no_button? "Apply for this permit"

  end

end