Frustration::Application.routes.draw do

  get "users/show"

  # root
  root :to => 'top#index'

  #-----------------------------------------------
  # web
  #-----------------------------------------------
  match 'login'  => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match "/auth/:provider/callback" => "sessions#create"
  resources :sessions, :only => %w[new create destroy]

  match "users/new" => 'users#new', :via => :get
  match "users"     => 'users#create', :via => :post

  match "home" => 'home#index', :via => :get
  scope "/settings", as: :settings do
    match '/icon'  => 'settings#icon', via: :get
    match '/profile'  => 'settings#profile', via: :get
    match '/categories' => 'settings#categories', via: :get
    match '/tags' => 'settings#tags', via: :get

    match '/twitter' => 'settings#twitter', via: :get
    match '/facebook' => 'settings#facebook', via: :get
    match '/gadget' => 'settings#gadget', via: :get
  end

  resources :fumans, :only => [:index] do
    collection do
      get 'search'
      get 'itunes'

    end
  end


  #-----------------------------------------------
  # api
  #-----------------------------------------------
  namespace :api do

    resources :me, :only => [:index] do
      collection do
        get 'loginedcheck'
        get 'friends_timeline'
        get 'user_timeline'

        post 'upload_file'
        put 'upload_icon'
      end

    end

    scope '/me/' do
      resources :categories
      resources :tags
      resources :fumans do
        resources :tags, only: [:create]
      end
    end


    resources :users, :only => [:create, :destroy]
    scope "/users/:username/" do
      match "/"  => 'users#show',  :via => :get

      #resources :photos, :only => [:index, :show] do
      #  match "/cools" => 'cools#create',  :via => :post
      #  match "/cools" => 'cools#destroy', :via => :delete
      #  resources :comments, :only => [:index, :create, :destroy]
      #end

      match "/follow/"   => 'friendships#create',  :via => :post
      match "/unfollow/" => 'friendships#destroy', :via => :delete

      match "/followings/" => 'friendships#followings', :via => :get
      match "/followers/" => 'friendships#followers', :via => :get
    end


  end
end
