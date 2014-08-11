require 'permit_params'
class PermitsController < ApplicationController
  include PermitParams

  def new
    @permit = Permit.new
    reset_session
  end

  def create
    @permit = Permit.new(permit_params)
    if @permit.save
      session[:permit_id] = @permit.id
      
      session[:selected_addition] = @permit.to_bool(@permit.selected_addition)
      session[:selected_acs_struct] = @permit.to_bool(@permit.selected_acs_struct)
      session[:selected_deck] = @permit.to_bool(@permit.selected_deck)
      session[:selected_pool] = @permit.to_bool(@permit.selected_pool)
      session[:selected_cover] = @permit.to_bool(@permit.selected_cover)
      session[:selected_window] = @permit.to_bool(@permit.selected_window)
      session[:selected_door] = @permit.to_bool(@permit.selected_door)
      session[:selected_wall] = @permit.to_bool(@permit.selected_wall)
      session[:selected_siding] = @permit.to_bool(@permit.selected_siding)
      session[:selected_floor] = @permit.to_bool(@permit.selected_floor)

      redirect_to permit_steps_path
    else
      render :new
    end
  end
end