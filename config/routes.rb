Hermes::Application.routes.draw do

  devise_for :users
  resources :users

  resources :websites do
    get :choose, :on => :collection
    resources :pages
  end
  
  root :to => 'users#index'
end
