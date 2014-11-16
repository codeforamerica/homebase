require 'project_params'
require 'securerandom'
require 'project_permit_creator'

class ProjectStepsController < ApplicationController
  include ProjectParams

  include Wicked::Wizard

  # Regular steps
  STEPS = [ :answer_screener, :display_permits, :enter_details, :confirm_terms, :display_summary, :submit_application ]

  # Error steps, steps that should only be jumped to when there's an error
  ERROR_STEPS = [ :error_page, :use_contractor ]

  steps *(STEPS + ERROR_STEPS)
  
  def show

    @project = current_project

    case step

    when :answer_screener
      @project_addition_screener = @project.addition_details
      @project_acs_struct_screener = @project.acs_struct_details
      @project_deck_screener = @project.deck_details
      @project_pool_screener = @project.pool_details


    when :display_permits

      if (@project.contractor)
        jump_to(:use_contractor)
      else
        @permit_needs = @project.get_permit_needed_info
        session[:permit_needs] = @permit_needs
      end

    when :enter_details

      @project.create_needed_permits
      @project_ac_options = @project.ac_options

    when :display_summary

      # Get hash of permit needs that was saved in session that will be used
      # to display permits in categories
      @permit_needs = session[:permit_needs]
      

    when :submit_application

      @unique_key = SecureRandom.hex

      # Will temporarily save the generated permit pdf in tmp folder
      file_path = "#{Rails.root}/tmp/#{@unique_key}.pdf"
      permit_created = ProjectPermitCreator.new(file_path, @project).create_permit

      if permit_created

        # Save the generated permit pdf in the model
        content = IO.binread file_path
        @permit_binary_detail = PermitBinaryDetail.create(file_data: content, 
                                                          permit_id: @project.id, 
                                                          filename: "#{@unique_key}.pdf")

        # Delete the temporary file after saved in the model

        File.delete file_path

        # Get hash of permit needs that was saved in session that will be used
        # to display permits in categories
        @permit_needs = session[:permit_needs]

        PermitMailer.send_permit_application(@project, @permit_needs, @unique_key).deliver

        @site_plan_required = ( @project.general_repair_permit.addition && @project.general_repair_permit.addition_area >= 125 ) ||
                                @project.general_repair_permit.acs_struct ||
                                @project.general_repair_permit.deck ||
                                @project.general_repair_permit.pool ||
                                @project.general_repair_permit.cover

      else
        jump_to(:error_page)       
      end

      

    end

    render_wizard

  end

  def update
    @project = current_project

    # Update status so model can perform validation accordingly
    if params[:project] == nil
      params[:project] = {}
    end
    params[:project][:status] = step.to_s

    # Currently the last step is submit application, because the later pages
    # are used as error paths, so will not use the steps.last for this
    params[:project][:status] = 'active' if step == :submit_application 

    # General Repair Permit
    if params[:project][:general_repair_permit_attributes]
      params[:project][:general_repair_permit_attributes][:project_status_to_be_saved] = step.to_s
    end

    # Add status update if there's more permits

    case step

    when :answer_screener

      # Need to show screener again if errors occur
      @project_addition_screener = @project.addition_details
      @project_acs_struct_screener = @project.acs_struct_details
      @project_deck_screener = @project.deck_details
      @project_pool_screener = @project.pool_details

      # This will fill out all the address information (address, latitude, longitude)
      fill_in_address_details

      @project.update_attributes(project_params)


    when :enter_details

      # Need to show ac options if errors occur
      @project_ac_options = @project.ac_options

      # This will limit the number of times Geocoder is called as there is a 
      # limit on the number of times this is being called per day
      # @TODO: May want to make all caps comparison so to prevent case sensitive issue"
      if params[:project][:owner_address].strip != @project.owner_address

        # This will fill out all the address information (address, latitude, longitude)
        fill_in_address_details
      end
      @project.update_attributes(project_params)

    when :confirm_terms

      # Remove leading or trailing spaces
      # @TODO: May want to make it all caps to prevent case sensitive compare later
      params[:project][:general_repair_permit_attributes][:confirmed_name] = params[:project][:general_repair_permit_attributes][:confirmed_name].strip
      @project.update_attributes(project_params)

    else # Default case  
      @project.update_attributes(project_params)
    end

    if @project.errors.any?
      # render the same step
      render_wizard
    else
      # render the next step
      render_wizard(@project)
    end
  end

  def serve

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

    address_details = CosaBoundary.address_details(params[:project][:owner_address])
    
    if address_details
      params[:project][:owner_address] = address_details[:full_address]
      params[:project][:lat] = address_details[:lat]
      params[:project][:lng] = address_details[:lng]
    else
      params[:project][:owner_address] = nil
      params[:project][:lat] = nil
      params[:project][:lng] = nil
    end
  end
end
