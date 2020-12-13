Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get ':id/items', to: 'search#show'
      end

      resources :merchants

      namespace :items do
        get ':id/merchant', to: 'search#show'
      end

      resources :items
   end
  end
end
