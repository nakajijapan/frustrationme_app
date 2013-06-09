Frustration::Application.routes.draw do


  # root
  root :to => 'top#index'

  #-----------------------------------------------
  # web
  #-----------------------------------------------
  # login/out
  match 'login',                    to: 'sessions#new',     as: :login
  match 'logout',                   to: 'sessions#destroy', as: :logout
  match '/auth/:provider/callback', to: 'sessions#create'
  resources :sessions, only: %w[new create destroy] do
    collection do
      get 'loggedin'
    end
  end

  # sign up
  resources :users, only: [:new, :create]

  resources :friendships, only: [:create] do
    collection do
      delete 'delete'
    end
  end

  # users
  scope '/users/:username', as: :users do
    match '/', to: 'users#show'
    match '/followings', to: 'friendships#followings'
    match '/followers',  to: 'friendships#followers'
  end

  scope '/password/', as: :passwords do
    match '/',      to: 'password#index', via: :get
    match '/sendmail',   to: 'password#sendmail',  via: :post
    match '/reset',  to: 'password#reset', via: :get
    match '/finish', to: 'password#finish', via: :put
  end

  # items
  resources :items, only: [:show] do
    resources :comments, only: [:index]
  end

  # home
  match 'home' => 'home#index', :via => :get

  # setting
  scope '/settings', as: :settings do
    match '/icon'       => 'settings#icon',    via: :get
    match '/profile'    => 'settings#profile', via: :get
    match '/profile'    => 'settings#profile_update', via: :put
    resources :categories
    #resources :tags
    resources :comments
    #match '/twitter'    => 'settings#twitter',  via: :get
    #match '/facebook'   => 'settings#facebook', via: :get
    #match '/gadget'     => 'settings#gadget',   via: :get
  end

  match 'fumans/'                 => 'fumans#index',      via: [:get, :post]
  match 'fumans/search'           => 'fumans#search',     via: [:get, :post]
  match 'fumans/categories/:type' => 'fumans#categories', via: :get
  resources :fumans, :only => [:index, :update, :destroy] do
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
      #resources :tags
      #resources :fumans do
      #  resources :tags, only: [:create]
      #end
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

    resources :fumans do
      collection do
        get 'statuses'
      end
    end
  end
end
