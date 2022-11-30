class Admin::UserPostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @topics = Topic.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_posts_path
  end
end
