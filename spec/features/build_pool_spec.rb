require 'spec_helper'

feature "Build a swimming pool" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a swimming pool that needs permit (in ground & less than or equal to 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check "Pool"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose "Pool is in ground"
    end

    within "div.pool_volume" do
      choose "Less than or equal to 5,000 gallons"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter the address of the property you're working on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Swimming Pool')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Homeowner name", with: "John Doe"
    page.has_field?('Home address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Homeowner email address", with: "john@johndoe.com"
    fill_in "Homeowner phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Building a new swimming pool in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content("Almost done! We filled in your permit applications")
    expect(page).to have_content("Make a detailed site plan")

  end

  scenario "when user selects a swimming pool that needs permit (in ground & more than 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check "Pool"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose "Pool is in ground"
    end

    within "div.pool_volume" do
      choose "More than 5,000 gallons"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter the address of the property you're working on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Swimming Pool')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Homeowner name", with: "John Doe"
    page.has_field?('Home address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Homeowner email address", with: "john@johndoe.com"
    fill_in "Homeowner phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Building a new swimming pool in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content("Almost done! We filled in your permit applications")
    expect(page).to have_content("Make a detailed site plan")

  end

  scenario "when user selects a swimming pool that do not need permit (above ground & less than and equal to 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check "Pool"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose "Pool is above ground"
    end

    within "div.pool_volume" do
      choose "Less than or equal to 5,000 gallons"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter the address of the property you're working on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_not_needed').should have_content('Swimming Pool')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a swimming pool that needs permit (above ground & more than 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check "Pool"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose "Pool is above ground"
    end

    within "div.pool_volume" do
      choose "More than 5,000 gallons"
    end

    within "div.contractor" do
      choose "No"
    end

    within "div.owner_address" do
      fill_in "Enter the address of the property you're working on.", with: "302 Madison St, San Antonio"
    end

    click_on "Submit"

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content("This is how to start your project(s)")

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content('Swimming Pool')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Homeowner name", with: "John Doe"
    page.has_field?('Home address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Homeowner email address", with: "john@johndoe.com"
    fill_in "Homeowner phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Building a new swimming pool in my backyard"
    fill_in "Job Cost", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "permit_accepted_terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content("Almost done! We filled in your permit applications")
    expect(page).to have_content("Make a detailed site plan")

  end


  after(:all) do
    @cosa.destroy
  end
end