Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  # 既存の LGTM をもらった記述（only）を維持したまま、
  # do ~ end を使って orders をネストさせます。
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :orders, only: [:index, :create]
  end
end