class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :email, :user_prefecture, :introduction, :is_deleted,)
    end
end
