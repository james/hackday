ActionController::Routing::Routes.draw do |map|
  
  map.resources :projects
  
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :conditions => { :method => :get }
  map.resource :session
  
  map.pages ':action', :controller => 'pages'

end
