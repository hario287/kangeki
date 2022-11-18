class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to post_path(@post.id)
    else
      @user = current_user
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
    @user = current_user
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = Post.find_by(params[:user_id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :category_id)
  end

end