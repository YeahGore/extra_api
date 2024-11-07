Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do

      resources :links, only: [:index, :create, :update, :destroy]
      resources :users, only: [:index, :create, :update]
      resources :teams, only: [:index, :create, :update, :destroy]
      resources :sessions, only: [:create]

      # get 'links/dashboard_index', to: 'links#dashboard_index' 
      # get 'links/counter_list', to: 'links#counter_list'
      # get 'links/:id', to: 'links#show'

      get 'users/list_of_roles', to: 'users#list_of_roles' 

    end
  end

end
