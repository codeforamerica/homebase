require 'permit_params'
class PermitsController < ApplicationController
  include PermitParams

  def new
    puts "========in permit_new: full path: #{request.fullpath}"
    @permit = Permit.new #do | pt |
    #   pt.selected_addition = session[:selected_addition]
    #   pt.selected_acs_struct = session[:selected_acs_struct]
    #   pt.selected_deck = session[:selected_deck]
    #   pt.selected_pool = session[:selected_pool]
    #   pt.selected_cover = session[:selected_cover]
    #   pt.selected_window = session[:selected_window]
    #   pt.selected_door = session[:selected_door]
    #   pt.selected_wall = session[:selected_wall]
    #   pt.selected_siding = session[:selected_siding]
    #   pt.selected_floor = session[:selected_floor]
    # end
    puts "*****************selected_addition: #{session[:selected_addition]}"
    puts "***********going to clear out session"
    # session.delete :selected_addition
    # session.delete :selected_acs_struct
    # session.delete :selected_deck
    # session.delete :selected_pool
    # session.delete :selected_cover
    # session.delete :selected_window
    # session.delete :selected_door
    # session.delete :selected_wall
    # session.delete :selected_siding
    # session.delete :selected_floor
    puts "*****************selected_addition: #{session[:selected_addition]}"
  end

  def create
    puts "========in permit_create: full path: #{request.fullpath}"
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