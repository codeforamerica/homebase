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
      params[:permit][:owner_address] = full_address(params[:permit][:owner_address])
      @permit.update_attributes(permit_params)
      session[:permit_needs] = @permit.update_permit_needs_for_projects
      # session[:contractor] = @permit.contractor

    when :enter_details
      params[:permit][:owner_address] = full_address(params[:permit][:owner_address])
      @permit.update_attributes(permit_params)
    when :confirm_terms
      @permit.confirmed_name = params[:permit][:confirmed_name]
      @permit.update_attributes(permit_params)
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
    # path = "#{Rails.root}/tmp/#{params[:filename]}.pdf"
    # @permit = current_permit
    # find permit details 
    #permit_binary_detail = PermitBinaryDetail.find_by permit_id: @permit.id
    permit_binary_detail = PermitBinaryDetail.find_by filename: "#{params[:filename]}.pdf"
    if permit_binary_detail
      send_data(permit_binary_detail.binary.data,
                :disposition => 'inline',
                :type => permit_binary_detail.content_type,
                :filename => permit_binary_detail.filename)
    end
  #   begin
  #     Timeout::timeout(15) do
  #       while !(File.exist? path) do
  #         # Not doing anything, just waiting
  #       end
  #       send_file( path,
  #         :disposition => 'inline',
  #         :type => 'application/pdf',
  #         :x_sendfile => true )
  #     end
  #   rescue Timeout::Error
  #     jump_to(:error_page)
  #     render_wizard
  #   end


  # @data = @upload.binary.data
  # send_data(@data, :type => @upload.content_type, :filename => @upload.filename, :disposition => 'download')


  end

  private

  def full_address address
    sa_bounds = Geokit::Geocoders::MultiGeocoder.geocode('San Antonio, TX').suggested_bounds
    address_details = Geokit::Geocoders::MultiGeocoder.geocode(address, bias: sa_bounds)

    if valid_address?(address_details)
      return address_details.full_address
    else
      return nil
    end
  end

  def valid_address? address
    address != nil && address.lat != nil && address.lng != nil && address.full_address != nil && address.street_name != nil
  end
end
