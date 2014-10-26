require 'project_params'
class ProjectsController < ApplicationController
  include ProjectParams

  def new
    @project = Project.new 
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      session[:project_id] = @project.id
      
      # session[:selected_addition] = @project.to_bool(@project.selected_addition)
      # session[:selected_acs_struct] = @project.to_bool(@project.selected_acs_struct)
      # session[:selected_deck] = @project.to_bool(@project.selected_deck)
      # session[:selected_pool] = @project.to_bool(@project.selected_pool)
      # session[:selected_cover] = @project.to_bool(@project.selected_cover)
      # session[:selected_window] = @project.to_bool(@project.selected_window)
      # session[:selected_door] = @project.to_bool(@project.selected_door)
      # session[:selected_wall] = @project.to_bool(@project.selected_wall)
      # session[:selected_siding] = @project.to_bool(@project.selected_siding)
      # session[:selected_floor] = @project.to_bool(@project.selected_floor)

      redirect_to permit_steps_path
    else
      render :new
    end
  end
end