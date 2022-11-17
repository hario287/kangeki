class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = current_user
    @reviews = @user.reviews
    @posts = @user.posts
  end

  def index
    @users = User.all
  end


  def edit
    @user = current_user
  end

  def update
     @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render "edit"
    end
  end

  def unsubscribe
  end

  #退会処理
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:review_id)
    @favorite_reviews = Review.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :user_prefecture, :introduction, :is_deleted,)
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
