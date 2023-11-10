Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get "inns/show/:id", to: "visitors#show", as: "show_inn"
  get "search_inns", to: "visitors#search_inns"
  get "advanced_search_inns", to: "visitors#advanced_search_inns"

  resources :inns, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:new, :create], shallow: true do
      resources :custom_prices, only: [:new, :create]
    end
  end

  resources :rooms, only: [:index, :show, :edit, :update]
  resources :custom_prices, only: [:edit, :update, :destroy]

  resources :cities, only: [:index] do
    get "search", on: :collection
  end

end
