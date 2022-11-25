Rails.application.routes.draw do

  namespace :admin do
    get 'searches/search'
  end
# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#ゲストユーザー用
devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

#ユーザー側
scope module: :public do
  root 'homes#top'
  get 'about' => "homes#about", as: 'about'

  resources :users do
    get 'favorites' => 'users#favorites', as: 'favorites'
    resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :reviews do
    resources :review_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

# 退会機能
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"

 end

#管理者側
namespace :admin do
  resources :users, only:[:index, :show, :edit, :update]
  resources :user_posts, only:[:index, :show, :destroy]
  resources :user_reviews, only:[:index, :show, :destroy]
  resources :topics, only:[:index, :create, :edit, :update]
  # 検索
  get "search" => "searches#search"
end
end