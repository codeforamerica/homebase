require 'spec_helper'

feature "Build an addition" do
  
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  scenario "when user selects a Room Addition that needs permit (Greater than or equal to 1000 sq ft and more than 125 sq feet & 1 story)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Less than 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "1 story"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Addition')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Name", with: "John Doe"
    page.has_field?('Street address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Email address", with: "john@johndoe.com"
    fill_in "Phone number", with: "413-456-3456"

    fill_in "Size of existing house in square feet", with: "1234"
    fill_in "Size of new addition in square feet", with: "350"
    select "Wall Unit", from: "Air conditioning / heating system"

    fill_in "Work Summary", with: "Building an addition in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/permit_steps/display_summary')
    expect(page).to have_content("Congrats! You filled out your permit application")
    expect(page).to have_content("Make a detailed site plan")

  end

  scenario "when user selects a Room Addition that needs permit (Greater than or equal to 1000 sq ft and equal to 125 sq feet & 1 story)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Less than 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "1 story"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Addition')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Name", with: "John Doe"
    page.has_field?('Street address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Email address", with: "john@johndoe.com"
    fill_in "Phone number", with: "413-456-3456"

    fill_in "Size of existing house in square feet", with: "1234"
    fill_in "Size of new addition in square feet", with: "125"
    select "Wall Unit", from: "Air conditioning / heating system"

    fill_in "Work Summary", with: "Building an addition in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/permit_steps/display_summary')
    expect(page).to have_content("Congrats! You filled out your permit application")
    expect(page).to have_content("Make a detailed site plan")

  end

  scenario "when user selects a Room Addition that needs permit (Greater than or equal to 1000 sq ft and less than 125 sq feet & 1 story)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Less than 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "1 story"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Addition')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Name", with: "John Doe"
    page.has_field?('Street address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Email address", with: "john@johndoe.com"
    fill_in "Phone number", with: "413-456-3456"

    fill_in "Size of existing house in square feet", with: "1234"
    fill_in "Size of new addition in square feet", with: "124"
    select "Wall Unit", from: "Air conditioning / heating system"

    fill_in "Work Summary", with: "Building an addition in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/permit_steps/display_summary')
    expect(page).to have_content("Congrats! You filled out your permit application")
    expect(page).not_to have_content("Make a detailed site plan")

  end





  scenario "when user selects a Room Addition that needs further assistance (Greater than or equal to 1000 sq ft & 1 story)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Greater than or equal to 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "1 story"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.further_assistance_needed').should have_content('Addition')

    page.has_no_button? "Apply for this permit"

  end


  scenario "when user selects a Room Addition that needs further assistance (less than to 1000 sq ft & 2 or more stories)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Less than 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "2 or more stories"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.further_assistance_needed').should have_content('Addition')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a Room Addition that needs further assistance (Greater than or equal to 1000 sq ft & 2 or more stories)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Greater than or equal to 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "2 or more stories"
    end

    within "div.contractor" do
      choose "I'm doing the work myself (with help my friends or family)"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.further_assistance_needed').should have_content('Addition')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a Room Addition using a contractor (less than to 1000 sq ft & 1 story)" do

    visit '/permits'

    # permit#new
    check "Room Addition"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.addition_size" do
      choose "Less than 1,000 sq ft"
    end

    within "div.addition_num_story" do
      choose "1 story"
    end

    within "div.contractor" do
      choose "I'm hiring a contractor"
    end

    within "div.owner_address" do
      fill_in "Enter the address of your home you'll do work on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/permit_steps/use_contractor')
    expect(page).to have_content("Oh you’re using a contractor.")

  end

  after(:all) do
    @cosa.destroy
  end
end