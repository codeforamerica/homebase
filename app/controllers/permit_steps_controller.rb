require 'permit_params'
require 'geokit'
require 'securerandom'

class PermitStepsController < ApplicationController
  include PermitParams
  include PermitStepsHelper

  include Wicked::Wizard
  steps :answer_screener, :display_permits, :enter_details, :confirm_terms, :display_summary, 
  
  # The following are error pages that should only be jump to:
  :error_page, :use_contractor, :cannot_help, :do_not_need_permit
  
  def show
    @permit = current_permit

    @permit.selected_addition = session[:selected_addition]
    @permit.selected_acs_struct = session[:selected_acs_struct]
    @permit.selected_deck = session[:selected_deck]
    @permit.selected_pool = session[:selected_pool]
    @permit.selected_cover = session[:selected_cover]
    @permit.selected_window = session[:selected_window]
    @permit.selected_door = session[:selected_door]
    @permit.selected_wall = session[:selected_wall]
    @permit.selected_siding = session[:selected_siding]
    @permit.selected_floor = session[:selected_floor]
    case step

    when :answer_screener

      #@permit.contractor = session[:contractor]

    when :display_permits

      #@permit.contractor = session[:contractor]
      #puts "What is contractor? #{@permit.contractor}"
      if (@permit.contractor)
        #puts "going to jump to contractor page"
        jump_to(:use_contractor)
      else
        puts "continue to next"
        @permit_needs = session[:permit_needs]
      end


    when :display_summary

      puts "in display summary"
      @unique_key = SecureRandom.hex
      file_path = "#{Rails.root}/tmp/#{@unique_key}.pdf"
      permit_created = create_permit(file_path, @permit)

      if permit_created

        content = IO.binread file_path
        @permit_binary_detail = PermitBinaryDetail.create(file_data: content, 
                                                          permit_id: @permit.id, 
                                                          filename: "#{@unique_key}.pdf")
        File.delete file_path

      else
        jump_to(:error_page)
        
      end
    end
    render_wizard

  end

  def update
    @permit = current_permit

    # checks if permit is done so model knows when to do validation
    params[:permit][:status] = step.to_s
    params[:permit][:status] = 'active' if step == steps.last

    case step

    when :answer_screener

      params[:permit][:selected_addition] = session[:selected_addition]
      params[:permit][:selected_acs_struct] = session[:selected_acs_struct]
      params[:permit][:selected_deck] = session[:selected_deck]
      params[:permit][:selected_pool] = session[:selected_pool]
      params[:permit][:selected_cover] = session[:selected_cover]
      params[:permit][:selected_window] = session[:selected_window]
      params[:permit][:selected_door] = session[:selected_door]
      params[:permit][:selected_wall] = session[:selected_wall]
      params[:permit][:selected_siding] = session[:selected_siding]
      params[:permit][:selected_floor] = session[:selected_floor]

      fill_in_address_details

      @permit.update_attributes(permit_params)
      session[:permit_needs] = @permit.update_permit_needs_for_projects
      # session[:contractor] = @permit.contractor

    when :enter_details

      # This will limit the number of times Geocoder is called as there is a limit on the number of times this is being called per day
      if params[:permit][:owner_address].strip != @permit.owner_address
        fill_in_address_details
      end
      @permit.update_attributes(permit_params)

    when :confirm_terms
      puts "in confirm_terms"
      @permit.confirmed_name = params[:permit][:confirmed_name].strip
      @permit.update_attributes(permit_params)
      puts "@permit.confirmed_name: #{@permit.confirmed_name}"
      puts "params[:permit][:confirmed_name]: #{params[:permit][:confirmed_name]}"
    else
      @permit.update_attributes(permit_params)
    end

    if @permit.errors.any?
      puts "*****************************************"
      puts "#{@permit.errors}"
      # render the same step
      render_wizard
    else
      # render the next step
      render_wizard(@permit)
    end
  end

  def serve
    permit_binary_detail = PermitBinaryDetail.find_by filename: "#{params[:filename]}.pdf"
    if permit_binary_detail
      send_data(permit_binary_detail.binary.data,
                :disposition => 'inline',
                :type => permit_binary_detail.content_type,
                :filename => permit_binary_detail.filename)
    end
  end

  private
  def fill_in_address_details

    address_details = CosaBoundary.address_details(params[:permit][:owner_address])
    params[:permit][:owner_address] = address_details[:full_address]
    params[:permit][:lat] = address_details[:lat]
    params[:permit][:lng] = address_details[:lng]
  end
end
