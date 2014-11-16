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

      redirect_to project_steps_path
    else
      render :new
    end
  end
end