Rails.application.routes.draw do
  # devise（ユーザー認証）
  devise_for :users

  # フリマアプリのトップページ
  root "items#index"

  # 商品リソース
  resources :items
end
