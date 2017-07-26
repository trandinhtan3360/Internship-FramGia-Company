Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'   
  resources :bubbles
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get  '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  match '/signup',  to: 'users#new', via: 'get' 
  match '/help',    to: 'static_pages#help',    via: 'get'
  post 'users/create'
  resources :users 
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
