Frustration::Application.routes.draw do

  get 'users/show'

  # root
  root :to => 'top#index'

  #-----------------------------------------------
  # web
  #-----------------------------------------------
  match 'login'  => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  match '/auth/:provider/callback' => 'sessions#create'
  resources :sessions, :only => %w[new create destroy]

  match 'users/new' => 'users#new', :via => :get
  match 'users'     => 'users#create', :via => :post

  match 'home' => 'home#index', :via => :get
  #match 'search' => 'home#search', via: [:get, :post]

  scope '/settings', as: :settings do
    match '/icon'       => 'settings#icon', via: :get
    match '/profile'    => 'settings#profile', via: :get
    resources :categories
    resources :tags
    resources :comments

    match '/twitter'    => 'settings#twitter', via: :get
    match '/facebook'   => 'settings#facebook', via: :get
    match '/gadget'     => 'settings#gadget', via: :get
  end

  match 'fumans/search' => 'fumans#search', via: [:get, :post]
  match 'fumans/categories/:type' => 'fumans#categories', via: :get
  resources :fumans, :only => [:index] do
    collection do
      get 'itunes'
      post 'create_with_item'
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
        put  'upload_icon'
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
    scope '/users/:username/' do
      match '/'  => 'users#show',  :via => :get

      #resources :photos, :only => [:index, :show] do
      #  match '/cools' => 'cools#create',  :via => :post
      #  match '/cools' => 'cools#destroy', :via => :delete
      #  resources :comments, :only => [:index, :create, :destroy]
      #end

      match '/follow/'   => 'friendships#create',  :via => :post
      match '/unfollow/' => 'friendships#destroy', :via => :delete

      match '/followings/' => 'friendships#followings', :via => :get
      match '/followers/' => 'friendships#followers', :via => :get
    end


  end
end
