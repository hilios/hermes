Hermes::Application.routes.draw do

  devise_for :users
  resources :users
  
  resources :websites do
    get :select, :on => :collection, :as => :select
    resources :resources
  end
  
  root :to => 'websites#select'
end
