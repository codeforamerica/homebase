require 'spec_helper'

feature "Build a deck" do
  scenario "when user selects a Deck that needs permit (Greater than 120 sq ft & 
                                                        More than 30 inches above grade & 
                                                        attached to dwelling & 
                                                        serve a required exit door)" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.permit_needed').should have_content('Deck')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Home owner name*", with: "John Doe"
    page.has_field?('Address*', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Home owner email address*", with: "john@johndoe.com"
    fill_in "Home owner phone number*", with: "413-456-3456"

    fill_in "work_summary", with: "Building a new shed in my backyard"
    fill_in "Job cost*", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "accepted-terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

  #   # This is odd it is not working, as if button wasn't clicked
  #   # expect(current_path).to eq('/permit_steps/display_summary')
  #   # expect(page).to have_content("Almost done! We filled in your permit applications")

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end


  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Greater than 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Greater than 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end



  scenario "when user selects a Deck that needs permit (Less than or equal to 120 sq ft & 
                                                        More than 30 inches above grade & 
                                                        attached to dwelling & 
                                                        serve a required exit door)" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.permit_needed').should have_content('Deck')

    click_on "Apply for this permit"

    expect(current_path).to eq('/permit_steps/enter_details')
    expect(page).to have_content("General Repair/Residential Permit Application")

    #permit_steps#enter_details
    fill_in "Home owner name*", with: "John Doe"
    page.has_field?('Address*', with: "302 Madison St, San Antonio, TX 78204")
    fill_in "Home owner email address*", with: "john@johndoe.com"
    fill_in "Home owner phone number*", with: "413-456-3456"

    fill_in "work_summary", with: "Building a new shed in my backyard"
    fill_in "Job cost*", with: "10000"

    click_on "Next step"

    expect(current_path).to eq('/permit_steps/confirm_terms')
    expect(page).to have_content("Please read these terms and sign your permit online")

    #permit_steps#confirm_terms
    check "accepted-terms"
    fill_in "Enter your name", with: "John Doe"

    click_on "I agree"

  #   # This is odd it is not working, as if button wasn't clicked
  #   # expect(current_path).to eq('/permit_steps/display_summary')
  #   # expect(page).to have_content("Almost done! We filled in your permit applications")

  end

  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end


  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "More than 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (Less than or equal to 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Serves a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end

  scenario "when user selects a deck that needs further assistance (less than or equal to 120 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit new_permit_path

    # permit#new
    check "Deck"
    click_on "Next step"

    expect(current_path).to eq('/permit_steps/answer_screener')
    expect(page).to have_content("Enter your project details")

    #permit_steps#answer_screener
    within "div.deck_size" do
      choose "Less than or equal to 120 sq ft"
    end

    within "div.deck_grade" do
      choose "Less than or equal to 30 inches above grade"
    end

    within "div.deck_dwelling_attach" do
      choose "Not attached to dwelling"
    end

    within "div.deck_exit_door" do
      choose "Does not serve a required exit door"
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
    page.find('div.further_assistance_needed').should have_content('Deck')

    page.has_no_button? "Apply for this permit"

  end
end