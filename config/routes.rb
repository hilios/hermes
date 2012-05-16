Hermes::Application.routes.draw do

  devise_for :users
  resources :users

  resources :resources

  resources :websites do
    get :choose, :on => :collection
  end
  
  root :to => 'users#index'
end
