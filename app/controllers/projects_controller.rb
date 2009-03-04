class ProjectsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  before_filter :require_owner, :only => [:edit, :update]
  before_filter :require_user, :only => [:new, :create]
  
  def current_object
    @current_object ||= current_model.find_by_slug(params[:id])
  end
  
  private
  
  def require_user
    redirect_to new_session_path(:new_project => true) unless session[:openid_url]
  end
  
  def require_owner
    redirect_to new_session_path(:project => @current_object) unless session[:openid_url] && session[:openid_url] == @current_object.openid
  end
end
