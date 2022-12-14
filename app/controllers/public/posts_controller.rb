class Public::PostsController < ApplicationController
  before_action :authenticate_user!, unless: :admin_signed_in?

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
      render "new"
    end
  end

  def index
    @user = current_user
    @post = Post.new
    @posts = Post.page(params[:page])

    @topics = Topic.all
    if params[:topic] != nil
      @topic_p = params[:topic]
      @topic_search = Post.where(topic_id: @topic_p)
      @posts = @topic_search.order(created_at: :desc).page(params[:page]).per(8)
      @topic = Topic.find_by(id: @topic_p)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @post_comment = PostComment.new
    @topics = Topic.all
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
