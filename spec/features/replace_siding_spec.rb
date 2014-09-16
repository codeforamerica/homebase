require 'spec_helper'

feature "Replace sidings" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects Replace siding that doesn't need permit (Only placing new siding over existing)" do

    visit '/permits'

    # permit#new
    check "Replace siding"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.siding_over_existing" do
      choose "Yes"
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
    page.find('div.permit_not_needed').should have_content('Replace Siding')

    page.has_no_button? "Apply for this permit"

  end
  
  scenario "when user selects Replace siding that needs permit (Only placing new siding over existing)" do

    visit '/permits'

    # permit#new
    check "Replace siding"
    click_on "Next step"

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.siding_over_existing" do
      choose "No"
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
    page.find('div.permit_needed').should have_content('Replace Siding')

    click_on "Apply for this permit"

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details

    fill_in "Homeowner name", with: "John Doe"
    page.has_field?('Home address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Homeowner email address", with: "john@johndoe.com"
    fill_in "Homeowner phone number", with: "413-456-3456"

    fill_in "Work Summary", with: "Replace siding in my backyard"
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
    expect(page).not_to have_content("Make a detailed site plan")

  end

  after(:all) do
    @cosa.destroy
  end
end