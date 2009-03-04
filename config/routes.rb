ActionController::Routing::Routes.draw do |map|
  # map.root :controller => 'projects'
  
  map.projects '', :controller => 'projects', :method => 'index'
  map.resources :projects, :except => [:index]
  
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :conditions => { :method => :get }
  map.resource :session
end
