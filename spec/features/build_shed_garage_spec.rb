require 'spec_helper'

feature "Build a shed or garage" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a Shed or Garage that needs permit (Greater than 120 sq ft & 1 story)" do

    visit '/permits'

    # permit#new
    check "Shed or Garage"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.acs_struct_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.acs_struct_num_story" do
      choose "1 story"
    end

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
    page.find('div.permit_needed').should have_content('Shed/Garage')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Name", with: "John Doe"
    page.has_field?('Street address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Email address", with: "john@johndoe.com"
    fill_in "Phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Building a new shed in my backyard"
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

  scenario "when user selects a Shed or Garage that do not need permit (Less than or equal to 120 sq ft & 1 story))" do

    visit '/permits'

    # permit#new
    check "Shed or Garage"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.acs_struct_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.acs_struct_num_story" do
      choose "1 story"
    end

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
    page.find('div.permit_not_needed').should have_content('Shed/Garage')

    page.has_no_button? "Apply for this permit"

  end


  scenario "when user selects a Shed or Garage that needs further assistance (Less than or equal to 120 sq ft & 2 or more stories)" do

    visit '/permits'

    # permit#new
    check "Shed or Garage"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.acs_struct_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.acs_struct_num_story" do
      choose "2 or more stories"
    end

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
    page.find('div.further_assistance_needed').should have_content('Shed/Garage')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a Shed or Garage that needs further assistance (Greater than 120 sq ft & 2 or more stories)" do

    visit '/permits'

    # permit#new
    check "Shed or Garage"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.acs_struct_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.acs_struct_num_story" do
      choose "2 or more stories"
    end

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
    page.find('div.further_assistance_needed').should have_content('Shed/Garage')

    page.has_no_button? "Apply for this permit"

  end

  after(:all) do
    @cosa.destroy
  end
end