Rails.application.routes.draw do

root 'public/homes#top'

    get 'users/mypage' => "users#show"
    get 'users/index'
    get 'users/edit'

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

end