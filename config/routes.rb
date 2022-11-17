Rails.application.routes.draw do

 root 'public/homes#top'

#ゲストユーザー用
devise_scope :user do
  post 'users_guest_sign_in', to: 'users/sessions#guest_sign_in'
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
  resources :posts, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :reviews,only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :review_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
 end

  get "users/mypage" => "users#show"
  get "users/information/edit" => "users#edit"
  patch "users/information" => "users#update"

  get "users/unsubscribe" => "users#unsubscribe"
  patch "users/withdraw" => "users#withdraw"
  end