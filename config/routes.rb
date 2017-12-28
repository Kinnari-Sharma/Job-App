Rails.application.routes.draw do


  root 'general_pages#home'
  get  '/help',    to: 'general_pages#help'
  get  '/about',    to: 'general_pages#about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/admin', to: 'admin#show'
  namespace :admin do
    resources :categories, only: [ :create, :destroy]
    resources :jobtypes, only: [ :create, :destroy]
    resources :users, only: [:index, :destroy]
    resources :jobs, only: [:destroy, :update]
  end
  get '/auth/linkedin/callback', to: 'sessionlinkedin#create'
  resources :users, except: [:index, :destroy]
  resources :jobs, except: [:update, :destroy]
  resources :applieds, only: [:create, :update]
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:new, :index, :create]
  end
end