class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_permit
    @current_permit ||= Permit.find_by_id(session[:permit_id]) if session[:permit_id]
  end
  helper_method :current_permit
end
