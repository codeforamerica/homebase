require 'spec_helper'

feature "Build a shed or garage" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a Shed or Garage that needs permit (Greater than 120 sq ft & 1 story)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.acs_struct')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.acs_struct_size" do
      choose I18n.t('models.project.acs_struct.size.options.gt_120')
    end

    within "div.acs_struct_num_story" do
      choose I18n.t('models.project.acs_struct.num_story.options.one')
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
    page.find('div.permit_needed').should have_content(I18n.t('models.project.acs_struct.name'))

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

  scenario "when user selects a Shed or Garage that do not need permit (Less than or equal to 120 sq ft & 1 story))" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.acs_struct')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.acs_struct_size" do
      choose I18n.t('models.project.acs_struct.size.options.lte_120')
    end

    within "div.acs_struct_num_story" do
      choose I18n.t('models.project.acs_struct.num_story.options.one')
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
    page.find('div.permit_not_needed').should have_content(I18n.t('models.project.acs_struct.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end


  scenario "when user selects a Shed or Garage that needs further assistance (Less than or equal to 120 sq ft & 2 or more stories)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.acs_struct')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.acs_struct_size" do
      choose I18n.t('models.project.acs_struct.size.options.lte_120')
    end

    within "div.acs_struct_num_story" do
      choose I18n.t('models.project.acs_struct.num_story.options.two_or_more')
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
    page.find('div.further_assistance_needed').should have_content(I18n.t('models.project.acs_struct.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end

  scenario "when user selects a Shed or Garage that needs further assistance (Greater than 120 sq ft & 2 or more stories)" do

    visit '/projects'

    # project#new
    check I18n.t('views.projects.new.project.acs_struct')
    click_on I18n.t('views.projects.new.submit')

    expect(current_path).to eq('/en/project_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.project_steps.answer_screener.header'))

    #project_steps#answer_screener
    within "div.acs_struct_size" do
      choose I18n.t('models.project.acs_struct.size.options.gt_120')
    end

    within "div.acs_struct_num_story" do
      choose I18n.t('models.project.acs_struct.num_story.options.two_or_more')
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
    page.find('div.further_assistance_needed').should have_content(I18n.t('models.project.acs_struct.name'))

    page.has_no_button? I18n.t('views.project_steps.display_permits.submit')

  end

  after(:all) do
    @cosa.destroy
  end
end