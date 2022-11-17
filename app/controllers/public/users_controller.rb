class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page])
    @posts = @user.posts.page(params[:page])
  end

  def index
    @users = User.all
  end


  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "変更しました。"
    else
      render "edit"
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  #退会処理
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end

  # いいね
  def favorites
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:review_id)
    @favorite_reviews = Review.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :user_prefecture, :introduction, :is_deleted,)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
