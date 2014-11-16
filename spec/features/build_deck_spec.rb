require 'spec_helper'

feature "Build a deck" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a Deck that needs permit (Greater than 200 sq ft & 
                                                        More than 30 inches above grade & 
                                                        attached to dwelling & 
                                                        serve a required exit door)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))
  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end


  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?('Steet address', with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Greater than 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.gt_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end



  scenario "when user selects a Deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    serve a required exit door)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end


  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    More than 30 inches above grade & 
                                                                    Not attached to dwelling & 
                                                                    Not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.gt_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that needs a permit (Less than or equal to 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.project.deck.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building a new shed in my backyard"
    fill_in I18n.t('views.project_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.project_steps.enter_details.submit')

    expect(current_path).to eq('/en/project_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.project_steps.confirm_terms.intro_text'))

    #project_steps#confirm_terms
    check I18n.t('views.project_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.project_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.project_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/project_steps/display_summary')
    expect(page).to have_content(I18n.t('views.project_steps.display_summary.intro.heading'))

    click_on I18n.t('views.project_steps.display_summary.permit.send_button')

    expect(page).to have_content(I18n.t('views.project_steps.submit_application.intro.heading'))
    expect(page).to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))

  end

  scenario "when user selects a deck that does not need a permit (less than or equal to 200 sq ft & 
                                                                    Less than or equal to 30 inches above grade & 
                                                                    not attached to dwelling & 
                                                                    not serve a required exit door))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.deck')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.deck_size" do
      choose I18n.t('models.project.deck.size.options.lte_200')
    end

    within "div.deck_grade" do
      choose I18n.t('models.project.deck.grade.options.lte_30')
    end

    within "div.deck_dwelling_attach" do
      choose I18n.t('models.project.deck.dwelling_attach.options.not_attached')
    end

    within "div.deck_exit_door" do
      choose I18n.t('models.project.deck.exit_door.options.not_served')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/display_permits')
    expect(page).to have_content(I18n.t('views.project_steps.display_permits.intro_text'))

    #project_steps#display_permits
    page.find('div.permit_not_needed').should have_content(I18n.t('models.project.deck.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end

  after(:all) do
    @cosa.destroy
  end
end