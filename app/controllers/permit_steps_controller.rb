require 'permit_params'
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
    @permit.update_attributes(permit_params)
    render_wizard @permit
end
end
