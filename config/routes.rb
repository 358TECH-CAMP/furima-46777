Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  # editとupdateを追加
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
end