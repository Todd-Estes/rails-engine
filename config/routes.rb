Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get ':id/items', to: 'search#show'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :merchants

      namespace :items do
        get ':id/merchant', to: 'search#show'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :items
   end
  end
end
