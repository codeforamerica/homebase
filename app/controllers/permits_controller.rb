require 'permit_params'
class PermitsController < ApplicationController
  include PermitParams

  def new
    @permit = Permit.new
  end

  def create
    @permit = Permit.new(permit_params)
    if @permit.save
      session[:permit_id] = @permit.id
      redirect_to permit_steps_path
    else
      render :new
    end
  end
end