Prowl::Application.routes.draw do
  get "deploys/:id", to: 'deploys#index', as: 'deploys'
  get "deploys/show/:id", to: 'deploys#show', as: 'deploy'
  get "deploys/new/:id", to: 'deploys#new', as: 'new_deploy'
  get "home/index"

  as :user do
    get "/login" => "devise/sessions#new", :as => :new_user_session
    post "/login" => "devise/sessions#create", :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  devise_for :users, :skip => [:registrations, :sessions]

  resources :users
  resources :apps
  resources :servers

  root :to => "home#index"
end