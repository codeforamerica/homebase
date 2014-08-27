class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def reset
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

    redirect_to root_url
  end

  private

  def current_permit
    @current_permit ||= Permit.find_by_id(session[:permit_id]) if session[:permit_id]
  end
  helper_method :current_permit
end
