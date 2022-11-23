class Admin::UserPostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    @topics = Topic.all
    @search_post = Post.where(topic_id: params[:topic]).order(created_at: :desc).page(params[:page]).per(8)
    @topic = Topic.find_by(id: params[:topic])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @post_comment = PostComment.new
    @topics = Topic.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_posts_path
  end
end
