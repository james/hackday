ActionController::Routing::Routes.draw do |map|
  map.resources :projects
  
  map.open_id_complete 'sessions', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.resources :sessions
end
