class SessionsController < ApplicationController
  def new
    @project = Project.find_by_slug(params[:project])
  end
  
  def create
    session[:project] = params[:project]
    session[:new_project] = params[:new_project]
    # session.close
    #FIXME: Aarrrgh, why does this not save to session?
    authenticate_with_open_id(nil) do |result, identity_url|
      if result.successful?
        session[:openid_url] = identity_url
        if project = Project.find_by_openid(session[:project])
          session[:project] = nil
          redirect_to edit_project_path(project)
        elsif session[:new_project]
          session[:new_project] = nil
          redirect_to new_project_path
        else
          redirect_to projects_path
        end
      else
        redirect_to :action => 'new'
      end
    end
  end
  
  def destroy
    session[:openid_url] = nil
    redirect_to '/'
  end
end
