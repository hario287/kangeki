class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, unless: :admin_signed_in?

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      @post_comment = PostComment.new(user: current_user)
      flash.now[:notice] = "コメントしました"
    else
      flash.now[:notice] = "コメントを入力してください"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:alert] = "コメントを削除しました"
    render :destroy
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment, :post_id)
    end
end