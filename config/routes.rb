Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :inns, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :show, :new, :create, :edit, :update]
  end
end
