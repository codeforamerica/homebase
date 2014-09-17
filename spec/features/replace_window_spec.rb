require 'spec_helper'

feature "Replace windows" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects windows that doesn't need permit (Replace Broken Glass only)" do

    visit '/permits'

    # permit#new
    check "Windows"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.window_replace_glass" do
      choose "Yes"
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
    page.find('div.permit_not_needed').should have_content('Windows')

    page.has_no_button? "Apply for this permit"

  end
  
  scenario "when user selects windows that needs permit (More than replacing Broken Glass only)" do

    visit '/permits'

    # permit#new
    check "Windows"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.window_replace_glass" do
      choose "No"
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
    page.find('div.permit_needed').should have_content('Windows')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "How many windows are you changing?", with: "2"

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
    check "permit[accepted_terms]"
    fill_in "permit_confirmed_name", with: "John Doe"
    # require 'debugger';debugger
    click_on "I agree"

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content("Congrats! You filled out your permit application")
    expect(page).not_to have_content("Make a detailed site plan")

  end

  after(:all) do
    @cosa.destroy
  end
end