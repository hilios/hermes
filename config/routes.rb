Hermes::Application.routes.draw do

  # Auth
  devise_for  :users

  resources   :users
  resource    :user, only: [:show, :edit, :update], as: :current_user
  
  resources :websites do
    get :manage, :on => :member, :as => :manage
  end

  # Creates for each asset class an exclusive route
  # with the following format:
  #   <class name without namespace>_path
  #
  # In the end the outputed route will web
  scope 'resources' do
    Resource.assets.each do |asset|
      resources :resources,
        as: asset.model_name.route_key,
        path: asset.model_name.singular_route_key, only: [:show, :new, :edit], _type: asset.name
    end
  end
  resources :resources, :except => [:show, :new, :edit] do
    get :preview, :on => :member
  end
  
  root :to => 'resources#index'
end
