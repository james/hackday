require 'rexml/document'

class ProjectsController < ApplicationController
  make_resourceful do
    actions :all
  end
  
  # before_filter :require_owner, :only => [:edit, :update]
  # before_filter :require_user, :only => [:new, :create]
  before_filter :fetch_svn_commits, :only => :show
  
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
  
  def fetch_svn_commits
    unless @project.svn_path.blank?
      xml = `svn log --limit 20 --xml --non-interactive  #{@project.svn_path}`
      doc = REXML::Document.new(xml)
      @svn_commits = []
      doc.elements.each('log/logentry'){|e| @svn_commits.push(:revision => e.attributes["revision"], :msg => e.text('msg'))}
    end
  end
end
