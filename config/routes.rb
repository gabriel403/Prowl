require "resque_web"
Prowl::Application.routes.draw do
  get "xhr/deploy_step_type"

  get   "server_app/link"
  get   "deploys/:id",      to: 'deploys#index',  as: 'deploys'
  post  "deploys/:id",      to: 'deploys#create'
  patch "deploys/:id",      to: 'deploys#update', as: 'edit_deploy'
  get   "deploys/show/:id", to: 'deploys#show',   as: 'deploy'
  get   "deploys/new/:id",  to: 'deploys#new',    as: 'new_deploy'

  get "home/index"

  devise_for :users, :skip => [:registrations, :sessions]

  as :user do
    get    "/login"  => "devise/sessions#new",     :as => :new_user_session
    post   "/login"  => "devise/sessions#create",  :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :users
  resources :apps
  resources :servers

  get  "server_app/link/:id/:from_type",      to: 'server_app#link', as: 'app_servers'
  post "server_app/link/:from_id/:from_type", to: 'server_app#linkcreate'

  resources :deploy_steps

  get "xhr/dst/:id", to: 'xhr#deploy_step_type', as: 'xhr_dst'

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "/resque_web"
    ResqueWeb::Engine.eager_load!
  end

  root :to => "home#index"
end
