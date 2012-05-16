Hermes::Application.routes.draw do

  resources :file_system

  devise_for :users
  resources :users

  resources :websites do
    get :choose, :on => :collection
  end
  
  root :to => 'users#index'
end
