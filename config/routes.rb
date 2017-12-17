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
  get '/auth/linkedin/callback', to: 'sessionlinkedin#create'
  resources :users
  resources :jobs
  resources :post_vacancies, only: [:new, :create, :show, :destroy]
  resources :applieds, only: [:create, :update]
  resources :categories, only: [ :create, :destroy]
  resources :jobtypes, only: [ :create, :destroy]
  resources :conversations, only: [:index, :create] do
    resources :messages
  end
end