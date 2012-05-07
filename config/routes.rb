Hermes::Application.routes.draw do

  devise_for :users
  resources :users
  resources :websites
  
  root :to => 'users#index'
end
