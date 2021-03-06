Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/merchants/find_all', to: 'merchants#find_all'
      get '/merchants/most_items', to: 'merchants#most_items'
      get '/revenue/merchants', to: 'revenues#top_merchants'
      get '/revenue', to: 'revenues#total_revenue_by_date'

      resources :merchants do

        resources :items, module: 'merchants', only: [:index, :show]
      end

      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'

      resources :items do
        resources :merchant, module: 'items', only: [:index, :show]
      end
    end
  end
end
