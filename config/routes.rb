Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :inns, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:new, :create], shallow: true do
      resources :custom_prices, only: [:new, :create]
    end
  end

  resources :rooms, only: [:index, :show, :edit, :update]
  resources :custom_prices, only: [:edit, :update, :destroy]

end
