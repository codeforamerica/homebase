require 'permit_params'
require 'geokit'
require 'securerandom'

class PermitStepsController < ApplicationController
  include PermitParams
  include PermitStepsHelper

  include Wicked::Wizard
  steps :enter_address, :display_permits, :enter_details, :display_summary
  
  def show
    @permit = current_permit

    case step

    when :display_summary

      @unique_key = SecureRandom.hex
      create_permit "#{Rails.root}/tmp/#{@unique_key}.pdf"
      # if ok, then show next wizard
      # else should show error
    end
    render_wizard

  end

  def update
    @permit = current_permit

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
    end

    @permit.update_attributes(permit_params)
    render_wizard @permit
  end

  def serve
    path = "#{Rails.root}/tmp/#{params[:filename]}.pdf"

    send_file( path,
      :disposition => 'inline',
      :type => 'application/pdf',
      :x_sendfile => true )
  end

  private

  def valid_address? address
    address != nil && address.lat != nil && address.lng != nil && address.full_address != nil && address.street_name != nil
  end
end
