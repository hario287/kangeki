class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

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
    @user = User.find(@post.user.id)
    # @user = User.find_by(name: 'guestUser')
    @post_comment = PostComment.new
    unless ViewCount.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.view_counts.create(post_id: @post.id)
    end
  end

  def edit
    @post = Post.find(params[:id])
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
    params.require(:post).permit(:title, :body, :post_image, :topic_id)
  end

end