Rails.application.routes.draw do

 root 'public/homes#top'

# ユーザー用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
 #ゲストユーザー用
  devise_scope :user do
    post 'users_guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

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
end