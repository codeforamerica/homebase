require 'permit_params'
require 'geokit'
require 'pdf_forms'

class PermitStepsController < ApplicationController
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
      pdftk = PdfForms.new('pdftk')
      path = "#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf"
      #@field_names = @pdftk.get_field_names("#{Rails.root}/lib/PermitForms/general-repairs-form-template.pdf")
      filled_in_form_path = "#{Rails.root}/tmp/application_1.pdf"


      pdftk.fill_form path, filled_in_form_path, { 
                                                    'DATE'                => Date.today.strftime("%m/%d/%Y"),
                                                    'JOB_COST'            => "$ #{@permit.job_cost}",
                                                    'OWNER_NAME'          => @permit.owner_name, 
                                                    'ADDRESS'             => @permit.owner_address,

                                                    'ADDITIONS_CHECKBOX'  => @permit.addition ? "X" : ' ',
                                                    'SQ_FOOT_HOUSE'       => @permit.house_area,
                                                    'SQ_FOOT_ADDITION'    => @permit.addition_area,
                                                    'AC_NONE'             => @permit.ac == "None" ? "X" : ' ',
                                                    'AC_WALL_UNIT'        => @permit.ac == "Wall Unit" ? "X" : ' ',
                                                    'AC_EXTENDED'         => @permit.ac == "Extended from Main House" ? "X" : ' ',
                                                    'AC_NEW_SPLIT'        => @permit.ac == "New Split System" ? "X" : ' ',

                                                    'GENERAL_REPAIRS_CHECKBOX'  => @permit.repair ? "X" : ' ',
                                                    'WINDOWS_CHECKBOX'          => @permit.window ? "X" : ' ',
                                                    'NUMBER_WINDOWS'            => @permit.window_count,
                                                    'DOORS_CHECKBOX'            => @permit.door ? "X" : ' ',
                                                    'NUMBER_DOORS'              => @permit.door_count,
                                                    'WALLS_CHECKBOX'            => @permit.wall ? "X" : ' ',
                                                    'SIDING_CHECKBOX'           => @permit.siding ? "X" : ' ',
                                                    'FLOOR_STRUCTURAL_CHECKBOX' => @permit.floor ? "X" : ' ',

                                                    'CONTRACTOR_NAME'           => @permit.contractor_name,
                                                    'CONTRACTOR_ID'             => @permit.contractor_id,
                                                    'ESCROW_YES_CHECKBOX'       => @permit.escrow ? "X" : ' ',
                                                    'ESCROW_NO_CHECKBOX'        => @permit.escrow ? ' ' : "X",
                                                    'REGISTERED_LICENSE_HOLDER' => @permit.license_holder,
                                                    'LICENSE_NUMBER'            => @permit.license_num,
                                                    'AUTHORIZED_AGENT_NAME'     => @permit.agent_name,
                                                    'CONTACT_ID_NUMBER'         => @permit.contact_id,
                                                    'PHONE'                     => @permit.phone,
                                                    'EMAIL'                     => @permit.email,
                                                    'OTHER_CONTACT_ID'          => @permit.other_contact_id,
                                                    'WORK_SUMMARY'              => @permit.work_summary

                                                  }
#["NCB", "AC_NONE", "AC_WALL_UNIT", "AC_EXTENDED", "AC_NEW_SPLIT", "DATE", "ADDRESS", "LOT", "BLOCK", "JOB_COST", "OWNER_NAME", "SQ_FOOT_HOUSE", "SQ_FOOT_ADDITION", "ADDITIONS_CHECKBOX", "ACCESSORY_STRUCTURE_CHECKBOX", "DECK_CHECKBOX", "SWIMMING_POOL_CHECKBOX", "CARPORTS_COVERS_CHECKBOX", "GENERAL_REPAIRS_CHECKBOX", "NUMBER_WINDOWS", "NUMBER_DOORS", "CONTRACTOR_NAME", "CONTRACTOR_ID", "LICENSE_NUMBER", "REGISTERED_LICENSE_HOLDER", "AUTHORIZED_AGENT_NAME", "CONTACT_ID_NUMBER", "TELEPHONE", "FAX", "WORK_SUMMARY", "EMAIL", "WINDOWS_CHECKBOX", "DOORS_CHECKBOX", "WALLS_CHECKBOX", "SIDING_CHECKBOX", "FLOOR_STRUCTURAL_CHECKBOX", "ESCROW_YES_CHECKBOX", "ESCROW_NO_CHECKBOX"]
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
