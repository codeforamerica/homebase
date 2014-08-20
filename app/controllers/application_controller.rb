class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def reset
    puts "before*****************selected_addition: #{session[:selected_addition]}"
    puts "before*****************selected_acs_struct: #{session[:selected_acs_struct]}"
    puts "before*****************selected_deck: #{session[:selected_deck]}"
    puts "before*****************selected_pool: #{session[:selected_pool]}"
    puts "before*****************selected_cover: #{session[:selected_cover]}"
    puts "before*****************selected_window: #{session[:selected_window]}"
    puts "before*****************selected_door: #{session[:selected_door]}"
    puts "before*****************selected_wall: #{session[:selected_wall]}"
    puts "before*****************selected_siding: #{session[:selected_siding]}"
    puts "before*****************selected_floor: #{session[:selected_floor]}"
    session.delete :selected_addition
    session.delete :selected_acs_struct
    session.delete :selected_deck
    session.delete :selected_pool
    session.delete :selected_cover
    session.delete :selected_window
    session.delete :selected_door
    session.delete :selected_wall
    session.delete :selected_siding
    session.delete :selected_floor

    puts "after*****************selected_addition: #{session[:selected_addition]}"
    puts "after*****************selected_acs_struct: #{session[:selected_acs_struct]}"
    puts "after*****************selected_deck: #{session[:selected_deck]}"
    puts "after*****************selected_pool: #{session[:selected_pool]}"
    puts "after*****************selected_cover: #{session[:selected_cover]}"
    puts "after*****************selected_window: #{session[:selected_window]}"
    puts "after*****************selected_door: #{session[:selected_door]}"
    puts "after*****************selected_wall: #{session[:selected_wall]}"
    puts "after*****************selected_siding: #{session[:selected_siding]}"
    puts "after*****************selected_floor: #{session[:selected_floor]}"
    redirect_to root_url
  end

  private

  def current_permit
    @current_permit ||= Permit.find_by_id(session[:permit_id]) if session[:permit_id]
  end
  helper_method :current_permit
end
