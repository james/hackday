ActionController::Routing::Routes.draw do |map|
  
  map.resources :projects
  map.resources :data_sources, :as => "data", :controller => "data"
  
  map.open_id_complete 'session', :controller => "sessions", :action => "create", :conditions => { :method => :get }
  map.resource :session
  
  map.pages ':action', :controller => 'pages'

end
