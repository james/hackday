class ProjectsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  before_filter :owner_only, :except => [:index, :show, :new, :create]
  
  def current_object
    @current_object ||= current_model.find_by_slug(params[:id])
  end
  
  private
  
  def owner_only
    redirect_to new_session_path(:project => @current_object) unless session[:openid_url] && session[:openid_url] == @current_object.openid
  end
end
