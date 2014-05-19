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
      address = Geokit::Geocoders::MultiGeocoder.geocode params[:permit][:owner_address]
      params[:permit][:owner_address] = address.full_address
    end

    @permit.update_attributes(permit_params)
    render_wizard @permit
  end
end
