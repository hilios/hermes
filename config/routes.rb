Hermes::Application.routes.draw do

  devise_for :users
  resources  :users
  
  resources :websites do
    get :select, :on => :collection, :as => :select
    match 'resources/new/:asset' => 'resources#new', :as => :new_asset_for, :on => :member
    resources :resources, :except => :new
  end
  
  root :to => 'websites#select'
end
