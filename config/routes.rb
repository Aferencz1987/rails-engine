Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      resources :merchants do

        resources :items, module: 'merchants', only: [:index, :show]
      end
      resources :items
    end
  end
end
