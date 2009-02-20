class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        session[:openid_url] = identity_url
        if project = Project.find_by_openid(identity_url)
          redirect_to edit_project_path(project)
        else
          redirect_to '/'
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
