Rails.application.routes.draw do


  root 'general_pages#home'
  get  '/help',    to: 'general_pages#help'
  get  '/about',    to: 'general_pages#about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/admin', to: 'admin#home'
  namespace :admin do
    resources :categories, except: [:new, :show, :index]
    resources :jobtypes, except: [:new, :show, :index]
    resources :users, except: [:new, :create]
    resources :jobs, only: [:destroy, :update, :show, :index]
  end
  get '/auth/linkedin/callback', to: 'sessionlinkedin#create'
  get '/auth/failure', to: 'sessionlinkedin#failure'
  resources :jobs
  resources :users, except: [:index, :destroy]
  resources :applieds, only: [:create, :update]
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:new, :index, :create]
  end
end