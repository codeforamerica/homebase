require 'spec_helper'

feature "Build a swimming pool" do

  before(:all) do 
    @cosa = FactoryGirl.create(:cosa_boundary)
  end
  
  scenario "when user selects a swimming pool that needs permit (in ground & less than or equal to 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check I18n.t('views.permits.new.project.pool')
    click_on I18n.t('views.permits.new.submit')

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.permit_steps.answer_screener.header'))

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose I18n.t('models.permit.pool.location.options.in_ground')
    end

    within "div.pool_volume" do
      choose I18n.t('models.permit.pool.volume.options.lte_5000')
    end

    within "div.contractor" do
      choose I18n.t('views.permit_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.permit_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.permit_steps.answer_screener.submit')

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content(I18n.t('views.permit_steps.display_permits.intro_text'))

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.permit.pool.name'))

    click_on I18n.t('views.permit_steps.display_permits.submit')

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content(I18n.t('views.permit_steps.enter_details.intro.heading'))

    #permit_steps#enter_details
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.permit_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.email.question'), with: "john@johndoe.com"
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.permit_steps.enter_details.final_info.work_summary.question'), with: "Building a new swimming pool in my backyard"
    fill_in I18n.t('views.permit_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.permit_steps.enter_details.submit')

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.permit_steps.confirm_terms.intro_text'))

    #permit_steps#confirm_terms
    check I18n.t('views.permit_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.permit_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.permit_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.intro.heading'))
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.site_plan.heading'))

  end

  scenario "when user selects a swimming pool that needs permit (in ground & more than 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check I18n.t('views.permits.new.project.pool')
    click_on I18n.t('views.permits.new.submit')

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.permit_steps.answer_screener.header'))

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose I18n.t('models.permit.pool.location.options.in_ground')
    end

    within "div.pool_volume" do
      choose I18n.t('models.permit.pool.volume.options.gt_5000')
    end

    within "div.contractor" do
      choose I18n.t('views.permit_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.permit_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.permit_steps.answer_screener.submit')

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content(I18n.t('views.permit_steps.display_permits.intro_text'))

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.permit.pool.name'))

    click_on I18n.t('views.permit_steps.display_permits.submit')

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content(I18n.t('views.permit_steps.enter_details.intro.heading'))

    #permit_steps#enter_details
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.permit_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.email.question'), with: "john@johndoe.com"
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.permit_steps.enter_details.final_info.work_summary.question'), with: "Building a new swimming pool in my backyard"
    fill_in I18n.t('views.permit_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.permit_steps.enter_details.submit')

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.permit_steps.confirm_terms.intro_text'))

    #permit_steps#confirm_terms
    check I18n.t('views.permit_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.permit_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.permit_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.intro.heading'))
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.site_plan.heading'))

  end

  scenario "when user selects a swimming pool that do not need permit (above ground & less than and equal to 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check I18n.t('views.permits.new.project.pool')
    click_on I18n.t('views.permits.new.submit')

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.permit_steps.answer_screener.header'))

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose I18n.t('models.permit.pool.location.options.above_ground')
    end

    within "div.pool_volume" do
      choose I18n.t('models.permit.pool.volume.options.lte_5000')
    end

    within "div.contractor" do
      choose I18n.t('views.permit_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.permit_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.permit_steps.answer_screener.submit')

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content(I18n.t('views.permit_steps.display_permits.intro_text'))

    #permit_steps#display_permits
    page.find('div.permit_not_needed').should have_content(I18n.t('models.permit.pool.name'))

    page.has_no_button? I18n.t('views.permit_steps.display_permits.submit')

  end

  scenario "when user selects a swimming pool that needs permit (above ground & more than 5,000 gallons)" do

    visit '/permits'

    # permit#new
    check I18n.t('views.permits.new.project.pool')
    click_on I18n.t('views.permits.new.submit')

    expect(current_path).to eq('/en/permit_steps/answer_screener')
    expect(page).to have_content(I18n.t('views.permit_steps.answer_screener.header'))

    #permit_steps#answer_screener
    within "div.pool_location" do
      choose I18n.t('models.permit.pool.location.options.above_ground')
    end

    within "div.pool_volume" do
      choose I18n.t('models.permit.pool.volume.options.gt_5000')
    end

    within "div.contractor" do
      choose I18n.t('views.permit_steps.answer_screener.contractor.options.no_statement')
    end

    within "div.owner_address" do
      fill_in I18n.t('views.permit_steps.answer_screener.owner_address.question'), with: "302 Madison St, San Antonio"
    end

    click_on I18n.t('views.permit_steps.answer_screener.submit')

    expect(current_path).to eq('/en/permit_steps/display_permits')
    expect(page).to have_content(I18n.t('views.permit_steps.display_permits.intro_text'))

    #permit_steps#display_permits
    page.find('div.permit_needed').should have_content(I18n.t('models.permit.pool.name'))

    click_on I18n.t('views.permit_steps.display_permits.submit')

    expect(current_path).to eq('/en/permit_steps/enter_details')
    expect(page).to have_content(I18n.t('views.permit_steps.enter_details.intro.heading'))

    #permit_steps#enter_details
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.name.question'), with: "John Doe"
    page.has_field?(I18n.t('views.permit_steps.enter_details.homeowner_info.address.question'), with: "302 Madison St, San Antonio, TX 78204")
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.email.question'), with: "john@johndoe.com"
    fill_in I18n.t('views.permit_steps.enter_details.homeowner_info.phone.question'), with: "413-456-3456"

    fill_in I18n.t('views.permit_steps.enter_details.final_info.work_summary.question'), with: "Building a new swimming pool in my backyard"
    fill_in I18n.t('views.permit_steps.enter_details.final_info.job_cost.question'), with: "10000"

    click_on I18n.t('views.permit_steps.enter_details.submit')

    expect(current_path).to eq('/en/permit_steps/confirm_terms')
    expect(page).to have_content(I18n.t('views.permit_steps.confirm_terms.intro_text'))

    #permit_steps#confirm_terms
    check I18n.t('views.permit_steps.confirm_terms.requirement.accept_text')
    fill_in I18n.t('views.permit_steps.confirm_terms.signature.confirmed_name.placeholder'), with: "John Doe"

    click_on I18n.t('views.permit_steps.confirm_terms.submit')

    expect(current_path).to eq('/en/permit_steps/display_summary')
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.intro.heading'))
    expect(page).to have_content(I18n.t('views.permit_steps.display_summary.site_plan.heading'))

  end


  after(:all) do
    @cosa.destroy
  end
end