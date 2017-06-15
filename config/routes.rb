Rails.application.routes.draw do
  resources :bubbles
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'users/new'
  post 'users/create'
  resources :users 
end
