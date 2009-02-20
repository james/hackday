class ProjectsController < ApplicationController
  resources_controller_for :projects
  
  def find_resource
    Project.find_by_slug(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
