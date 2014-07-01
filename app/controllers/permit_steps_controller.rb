require 'permit_params'
require 'geokit'

class PermitStepsController < ApplicationController
  include PermitParams

  include Wicked::Wizard
  steps :enter_address, :display_permits, :enter_details, :enter_repair, :display_summary
  
  def show
    @permit = current_permit

    case step

    when :enter_details
      skip_step if @permit.addition == nil || !@permit.addition
    end
    when :enter_repair
      skip_step if @permit.repair == nil || !@permit.repair
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
