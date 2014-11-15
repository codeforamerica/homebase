require 'spec_helper'

feature "Build an addition" do
  
  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end

  scenario "when user selects a Room Addition that needs permit (less than 1000 sq ft and more than 125 sq feet & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.lt_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.one')
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
    page.find('div.permit_needed').should have_content(I18n.t('models.project.addition.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.addition_info.house_area.question'), with: "1234"
    fill_in I18n.t('views.project_steps.enter_details.addition_info.addition_area.question'), with: "350"
    select "Wall unit", from: I18n.t('views.project_steps.enter_details.addition_info.ac.question')

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building an addition in my backyard"
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

  scenario "when user selects a Room Addition that needs permit (less than to 1000 sq ft and equal to 125 sq feet & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.lt_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.one')
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
    page.find('div.permit_needed').should have_content(I18n.t('models.project.addition.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.addition_info.house_area.question'), with: "1234"
    fill_in I18n.t('views.project_steps.enter_details.addition_info.addition_area.question'), with: "125"
    select "Wall unit", from: I18n.t('views.project_steps.enter_details.addition_info.ac.question')

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building an addition in my backyard"
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

  scenario "when user selects a Room Addition that needs permit (less than 1000 sq ft and less than 125 sq feet & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.lt_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.one')
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
    page.find('div.permit_needed').should have_content(I18n.t('models.project.addition.name'))

    click_on I18n.t('views.project_steps.display_permits.submit')

    expect(current_path).to eq('/en/project_steps/enter_details')
    expect(page).to have_content(I18n.t('views.project_steps.enter_details.intro.heading'))

    #project_steps#enter_details
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.project_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.email.question'), with: "john@johdoe.test"
    fill_in I18n.t('views.project_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.project_steps.enter_details.addition_info.house_area.question'), with: "1234"
    fill_in I18n.t('views.project_steps.enter_details.addition_info.addition_area.question'), with: "124"
    select "Wall unit", from: I18n.t('views.project_steps.enter_details.addition_info.ac.question')

    fill_in I18n.t('views.project_steps.enter_details.final_info.work_summary.question'), with: "Building an addition in my backyard"
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
    expect(page).not_to have_content(I18n.t('views.project_steps.submit_application.site_plan.heading'))
  end





  scenario "when user selects a Room Addition that needs further assistance (Greater than or equal to 1000 sq ft & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.gte_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.one')
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
    page.find('div.further_assistance_needed').should have_content(I18n.t('models.project.addition.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end


  scenario "when user selects a Room Addition that needs further assistance (less than to 1000 sq ft & 2 or more stories)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.lt_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.two_or_more')
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
    page.find('div.further_assistance_needed').should have_content(I18n.t('models.project.addition.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end

  scenario "when user selects a Room Addition that needs further assistance (Greater than or equal to 1000 sq ft & 2 or more stories)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.gte_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.two_or_more')
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
    page.find('div.further_assistance_needed').should have_content(I18n.t('models.project.addition.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end

  scenario "when user selects a Room Addition using a contractor (less than to 1000 sq ft & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.addition.raw')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.addition_size" do
      choose I18n.t('models.project.addition.size.options.lt_1000')
    end

    within "div.addition_num_story" do
      choose I18n.t('models.project.addition.num_story.options.one')
    end

    within "div.contractor" do
      choose I18n.t('views.project_steps.answer_screener.contractor.options.yes_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.project_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.project_steps.answer_screener.submit')

    expect(current_path).to eq('/en/project_steps/use_contractor')
    expect(page).to have_content(I18n.t('views.project_steps.use_contractor.description'))

  end

  after(:all) do
    @cosa.destroy
  end
end