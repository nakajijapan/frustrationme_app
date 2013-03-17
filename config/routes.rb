Frustration::Application.routes.draw do

  get 'users/show'

  # root
  root :to => 'top#index'

  #-----------------------------------------------
  # web
  #-----------------------------------------------
  # login/out
  match 'login'                    => 'sessions#new',     :as => :login
  match 'logout'                   => 'sessions#destroy', :as => :logout
  match '/auth/:provider/callback' => 'sessions#create'
  resources :sessions, :only       => %w[new create destroy]

  # sign up
  match 'users/new' => 'users#new',    :via => :get
  match 'users'     => 'users#create', :via => :post

  # home
  match 'home' => 'home#index', :via => :get

  # setting
  scope '/settings', as: :settings do
<<<<<<< HEAD
    match '/icon'       => 'settings#icon',    via: :get
=======
    match '/icon'       => 'settings#icon', via: :get
>>>>>>> 22d14e625c3fff9c389f057f8a4310655c01aaa6
    match '/profile'    => 'settings#profile', via: :get
    resources :categories
    resources :tags
    resources :comments

<<<<<<< HEAD
    match '/twitter'    => 'settings#twitter',  via: :get
    match '/facebook'   => 'settings#facebook', via: :get
    match '/gadget'     => 'settings#gadget',   via: :get
=======
    match '/twitter'    => 'settings#twitter', via: :get
    match '/facebook'   => 'settings#facebook', via: :get
    match '/gadget'     => 'settings#gadget', via: :get
>>>>>>> 22d14e625c3fff9c389f057f8a4310655c01aaa6
  end

  match 'fumans/'                 => 'fumans#index',      via: [:get, :post]
  match 'fumans/search'           => 'fumans#search',     via: [:get, :post]
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
