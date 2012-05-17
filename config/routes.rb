Hermes::Application.routes.draw do

  devise_for :users
  resources  :users
  
  resources :websites do
    get :select, :on => :collection, :as => :select
    match 'resources/new/:asset' => 'resources#new'
    resources :resources, :except => :new
  end
  
  root :to => 'websites#select'
end
