Rails.application.routes.draw do

 root 'public/homes#top'

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

#管理者側
namespace :admin do
  resources :users, only:[:index, :show, :edit, :update]
  resources :user_posts, only:[:index, :show, :edit, :destroy]
  resources :user_reviews, only:[:index, :show, :edit, :destroy]
  resources :categories, only:[:index, :create, :edit, :update]
end

#ユーザー側
scope module: :public do
  get 'about' => "homes#about", as: 'about'
  resources :posts do
    resources :post_comments, only: [:new, :create, :destroy]
  end

  resources :reviews do
    resources :review_comments, only: [:new, :create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only:[:index, :show, :edit, :update] do
    get 'history' => 'users#history', as: 'history'
    get 'favorites' => 'users#favorites', as: 'favorites'
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

# 退会機能
  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"

 end
end