require 'permit_params'
require 'geokit'
require 'pdf_forms'

class PermitStepsController < ApplicationController
      FORM_FIELDS = { owner_name: 'Text1 PG 1', owner_address: 'Text4 PG 1' }
        include PermitParams

  include Wicked::Wizard
  steps :enter_address, :display_permits, :enter_details, :enter_addition, :enter_repair, :display_summary
  
  def show
    @permit = current_permit

    case step

    when :enter_addition
      skip_step if @permit.addition == nil || !@permit.addition

    when :enter_repair
      skip_step if @permit.repair == nil || !@permit.repair

    when :display_summary
      @test = "Test"
      @pdftk = PdfForms.new('pdftk')
      #@path = "#{Rails.root}/lib/PermitForms/GeneralRepairsMinorCommercialApplication.pdf"
      path = "#{Rails.root}/lib/PermitForms/calfresh_application_single_page.pdf"
      @field_names = @pdftk.get_field_names("#{Rails.root}/lib/PermitForms/calfresh_application_single_page.pdf")
      #@field_names = @pdftk.get_field_names("#{Rails.root}/lib/PermitForms/GeneralRepairsMinorCommercialApplication.pdf")
      filled_in_form_path = "#{Rails.root}/tmp/application_1.pdf"


      @pdftk.fill_form path, filled_in_form_path, { FORM_FIELDS[:owner_name] => @permit.owner_name, FORM_FIELDS[:owner_address] => @permit.owner_address }

    end
    render_wizard

    end

  def update
    @permit = current_permit

    params[:permit][:status] = step.to_s
    params[:permit][:status] = 'active' if step == steps.last

    case step

    when :enter_address
      sa_bounds = Geokit::Geocoders::MultiGeocoder.geocode('San Antonio, TX').suggested_bounds
      address = Geokit::Geocoders::MultiGeocoder.geocode(params[:permit][:owner_address], bias: sa_bounds)

      if valid_address?(address)
        params[:permit][:owner_address] = address.full_address
      else
        puts "erroring out"
      end
    end

    @permit.update_attributes(permit_params)
    render_wizard @permit
  end

  private

  def valid_address? address
    address != nil && address.lat != nil && address.lng != nil && address.full_address != nil && address.street_name != nil
  end
end
