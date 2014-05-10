Rails.application.routes.draw do
  resources :access_levels, except: [:new, :edit]
  resources :deploy_steps, except: [:new, :edit]
  resources :deploy_step_types, except: [:new, :edit]
  resources :deploy_step_type_options, except: [:new, :edit]
  resources :deploy_options, except: [:new, :edit]
  resources :deploy_option_types, except: [:new, :edit]
  resources :deploys, except: [:new, :edit]
  resources :env_users, except: [:new, :edit]
  resources :env_servers, except: [:new, :edit]
  resources :envs, except: [:new, :edit]
  resources :servers, except: [:new, :edit]
  resources :apps, except: [:new, :edit]
  resources :organisation_users, except: [:new, :edit]
  resources :organisations, except: [:new, :edit]
  resources :authentication_types, except: [:new, :edit]

  devise_for :users, controllers: { sessions: 'sessions' }
  # resources :users, except: [:new, :edit]
  get '/users/show', to: 'users#show', as: 'user'
  get '/users', to: 'users#index', as: 'users'

  get 'home/index'
  root to: 'home#index'
end
