class LandingController < ApplicationController
  def index
    cookies[:addition] = params[:addition]

    logger.debug "addition in params: #{params[:addition]}"
    logger.debug "addition in cookies: #{cookies[:addition]}"
    logger.debug "addition in button: #{params[:button]}"
  end

end
