require 'permit_params'
require 'securerandom'

class PermitStepsController < ApplicationController
  include PermitParams
  include PermitStepsHelper

  include Wicked::Wizard

  # Regular steps
  STEPS = [ :answer_screener, :display_permits, :enter_details, :confirm_terms, :display_summary ]

  # Error steps, steps that should only be jumped to when there's an error
  ERROR_STEPS = [ :error_page, :use_contractor, :cannot_help, :do_not_need_permit ]

  steps *(STEPS + ERROR_STEPS)
  
  def show

    @permit = current_permit

    # Re-populate the permit project selection from session variables
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
      @permit_addition_screener = Permit::ADDITION
      @permit_acs_struct_screener = Permit::ACS_STRUCT
      @permit_deck_screener = Permit::DECK
      @permit_pool_screener = Permit::POOL


    when :display_permits

      if (@permit.contractor)
        jump_to(:use_contractor)
      else

        # Get hash of permit needs that was saved in session that will be used
        # to display permits in categories
        @permit_needs = session[:permit_needs]
      end

    when :enter_details

      @permit_ac_options = Permit::AC_OPTIONS

    when :display_summary

      puts "in display summary"
      @unique_key = SecureRandom.hex

      # Will temporarily save the generated permit pdf in tmp folder
      file_path = "#{Rails.root}/tmp/#{@unique_key}.pdf"
      permit_created = create_permit(file_path, @permit)

      if permit_created

        # Save the generated permit pdf in the model
        content = IO.binread file_path
        @permit_binary_detail = PermitBinaryDetail.create(file_data: content, 
                                                          permit_id: @permit.id, 
                                                          filename: "#{@unique_key}.pdf")

        # Delete the temporary file after saved in the model

        File.delete file_path

      else
        jump_to(:error_page)       
      end
    end

    render_wizard

  end

  def update
    @permit = current_permit

    # Update status so model can perform validation accordingly
    params[:permit][:status] = step.to_s

    # Currently the last step is display_summary, because the later pages
    # are used as error paths, so will not use the steps.last for this
    params[:permit][:status] = 'active' if step == :display_summary 

    case step

    when :answer_screener

      # Re-populate the permit project selection from session variables
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

      # Need to show screener again if errors occur
      @permit_addition_screener = Permit::ADDITION
      @permit_acs_struct_screener = Permit::ACS_STRUCT
      @permit_deck_screener = Permit::DECK
      @permit_pool_screener = Permit::POOL

      # This will fill out all the address information (address, latitude, longitude)
      fill_in_address_details

      @permit.update_attributes(permit_params)

      # Save hash of permit needs in session which will be used
      # to display permits in categories
      session[:permit_needs] = @permit.update_permit_needs_for_projects

    when :enter_details

      # Need to show ac options if errors occur
      @permit_ac_options = Permit::AC_OPTIONS

      # This will limit the number of times Geocoder is called as there is a 
      # limit on the number of times this is being called per day
      # @TODO: May want to make all caps comparison so to prevent case sensitive issue"
      if params[:permit][:owner_address].strip != @permit.owner_address

        # This will fill out all the address information (address, latitude, longitude)
        fill_in_address_details
      end
      @permit.update_attributes(permit_params)

    when :confirm_terms

      # Remove leading or trailing spaces
      # @TODO: May want to make it all caps to prevent case sensitive compare later
      params[:permit][:confirmed_name] = params[:permit][:confirmed_name].strip
      @permit.update_attributes(permit_params)
      
    else # Default case
      
      @permit.update_attributes(permit_params)
    end

    if @permit.errors.any?
      puts "*****************************************"
      puts "#{@permit.errors.to_hash.to_s}"
      # render the same step
      # @TODO: What does this mean?
      render_wizard
    else
      # render the next step
      render_wizard(@permit)
    end
  end

  def serve

    # @TODO: I don't understand why I need to attach this .pdf there.
    permit_binary_detail = PermitBinaryDetail.find_by filename: "#{params[:filename]}.pdf"

    if permit_binary_detail
      send_data(permit_binary_detail.binary.data,
                :disposition => 'inline',
                :type => permit_binary_detail.content_type,
                :filename => permit_binary_detail.filename)
    else
      # @TODO: Need to display an error page
      # render :error_page
    end
  end

  private

  # This will help fill in all associated address information in params (address, lat, lng)
  def fill_in_address_details

    address_details = CosaBoundary.address_details(params[:permit][:owner_address])
    
    if address_details
      params[:permit][:owner_address] = address_details[:full_address]
      params[:permit][:lat] = address_details[:lat]
      params[:permit][:lng] = address_details[:lng]
    else
      params[:permit][:owner_address] = nil
      params[:permit][:lat] = nil
      params[:permit][:lng] = nil
    end
  end
end
