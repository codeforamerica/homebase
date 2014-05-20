require 'permit_params'
require 'geokit'

class PermitStepsController < ApplicationController
  include PermitParams

  include Wicked::Wizard
  steps :enter_address, :display_permits, :enter_details, :display_summary
  
  def show
    @permit = current_permit
    render_wizard
  end

  def update
    @permit = current_permit
    case step

    when :enter_address
      sa_bounds = Geokit::Geocoders::MultiGeocoder.geocode('San Antonio, TX').suggested_bounds
      address = Geokit::Geocoders::MultiGeocoder.geocode(params[:permit][:owner_address], bias: sa_bounds)

      if valid_address?(address) && CosaBoundary.inCosa?(address.lat, address.lng)
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
