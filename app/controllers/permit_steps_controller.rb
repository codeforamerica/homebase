require 'permit_params'
require 'geokit'
require 'securerandom'

class PermitStepsController < ApplicationController
  include PermitParams
  include PermitStepsHelper

  include Wicked::Wizard
  steps :answer_screener, :display_permits, :enter_details, :confirm_terms, :display_summary, 
  
  # The following are error pages that should only be jump to:
  :error_page, :contractor, :cannot_help, :do_not_need_permit
  
  def show
    @permit = current_permit

    case step

    when :display_permits

      if (@permit.contractor)
        jump_to(:contractor)
      else
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

      params[:permit][:owner_address] = full_address(params[:permit][:owner_address])
      @permit.update_attributes(permit_params)
      session[:permit_needs] = @permit.update_permit_needs_for_projects
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
      # render the same step
      render_wizard
    else
      # render the next step
      render_wizard(@permit)
    end
  end

  def serve
    # path = "#{Rails.root}/tmp/#{params[:filename]}.pdf"
    @permit = current_permit
    # find permit details 
    permit_binary_detail = PermitBinaryDetail.find_by permit_id: @permit.id

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
