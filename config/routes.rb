Codemarks::Application.routes.draw do

  get '/welcome', to: "users#welcome", as: :welcome
  get '/about', to: "pages#about", as: :about
  get '/codemarklet_test', to: "pages#codemarklet_test"
  get '/pages/test_bookmarklet?:l&:url', :to => 'pages#test_bookmarklet', :as => :test_bookarklet

  resources :codemarklet, :only => [:new, :create] do
    collection do
      get :login
      get :chrome_extension
    end
  end

  resources :codemarks
  resources :topics
  resources :users

  resources :comments, :only => [:create, :destroy]
  get 'topics/:id/:user_id', :to => 'topics#show', :as => 'topic_user'

  resources :links, :only => [] do
    member do
      post :click
    end
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: 'sessions#failure'
  resources :sessions, :only => [:new, :create] do
    collection do
      get :codemarklet
      delete :destroy
    end
  end

  root :to => 'codemarks#index'
end
