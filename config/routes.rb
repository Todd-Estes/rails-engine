Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/items', to: 'search#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :merchants

      namespace :items do
        get '/:id/merchants', to: 'search#show'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
      end

      resources :items
   end
  end
end
