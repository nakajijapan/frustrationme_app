Frustration::Application.routes.draw do


  # root
  root to: 'top#index'

  #-----------------------------------------------
  # web
  #-----------------------------------------------
  # login/out
  get    'login',                    to: 'sessions#new',     as: :login
  get    'logout',                   to: 'sessions#destroy', as: :logout
  post   '/auth/:provider/callback', to: 'sessions#create'
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
    get '/', to: 'users#show'
    get '/followings', to: 'friendships#followings'
    get '/followers',  to: 'friendships#followers'
  end

  scope '/password/', as: :passwords do
    get  '/',         to: 'password#index'
    post '/sendmail', to: 'password#sendmail'
    get  '/reset',    to: 'password#reset'
    patch  '/finish',   to: 'password#finish'
  end

  # items
  resources :items, only: [:show] do
    resources :comments, only: [:index]
  end

  # home
  get 'home', to: 'home#index'

  # setting
  scope '/settings', as: :settings do
    get '/icon',       to: 'settings#icon'
    get '/profile',    to: 'settings#profile'
    patch '/profile',    to: 'settings#profile_update'
    resources :categories
    resources :comments
  end

  match 'fumans/',                  to: 'fumans#index',      via: [:get, :post]
  match 'fumans/search',            to: 'fumans#search',     via: [:get, :post]
  match 'fumans/categories/:type',  to: 'fumans#categories', via: :get
  resources :fumans, :only => [:index, :new, :update, :destroy] do
    collection do
      get 'itunes'
      post 'create_with_item'
    end
  end

  #-----------------------------------------------
  # api
  #-----------------------------------------------
  namespace :api do
    resources :tokens, only: [:create]

    resources :me, only: [:index] do
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
    end
    resources :users, only: [:create, :destroy]
    scope '/users/:username/' do
      get    '/',            to: 'users#show'
      post   '/follow/',     to: 'friendships#create'
      delete '/unfollow/',   to: 'friendships#destroy'
      get    '/followings/', to: 'friendships#followings'
      get    '/followers/',  to: 'friendships#followers'
    end

    resources :fumans do
      collection do
        get 'statuses'
      end
    end
  end
end
