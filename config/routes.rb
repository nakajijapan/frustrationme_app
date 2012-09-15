Frustration::Application.routes.draw do
  get "status/index"

  get "categories/index"

  get "tags/index"

  get "fumans/search"

  # root
  root :to => 'top#index'


  #-----------------------------------------------
  # web
  #-----------------------------------------------
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  resources :user_sessions, :only => %w[new create destroy]

  match "users/new" => 'users#new', :via => :get
  match "users"     => 'users#create', :via => :post

  match "home" => 'home#index', :via => :get
end
