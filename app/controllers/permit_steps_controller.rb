require 'permit_params'
require 'geokit'
require 'securerandom'

class PermitStepsController < ApplicationController
  include PermitParams
  include PermitStepsHelper

  include Wicked::Wizard
  steps :enter_address, :display_permits, :enter_details, :confirm_terms, :display_summary, :error_page
  
  def show
    @permit = current_permit

    case step

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

    if step == :enter_address || step == :enter_details
      sa_bounds = Geokit::Geocoders::MultiGeocoder.geocode('San Antonio, TX').suggested_bounds
      address = Geokit::Geocoders::MultiGeocoder.geocode(params[:permit][:owner_address], bias: sa_bounds)

      if valid_address?(address)
        params[:permit][:owner_address] = address.full_address
      else
        puts "erroring out"
      end
      
    elsif step == :confirm_terms
      confirmed_name = params[:permit][:confirmed_name]
      owner_name = @permit.owner_name

      # if the name in our db DOES NOT match the name they entered
      if !confirmed_name.eql?(owner_name)
        @terms_error = "The name you entered did not match the name you used on your permit application (#{@permit.owner_name}). Please type your name again."
      end

    end

    @permit.update_attributes(permit_params)
    if @terms_error != nil
      render_wizard
    else
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

  def valid_address? address
    address != nil && address.lat != nil && address.lng != nil && address.full_address != nil && address.street_name != nil
  end
end
