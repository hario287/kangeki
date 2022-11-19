class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    post_comment = current_user.post_comments.new(post_comment_params)
    post_comment.post_id = @post.id
    if post_comment.save
      flash.now[:notice] = "コメントしました"
      redirect_to post_path(@post)
    else
      render :error
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash.now[:alert] = "コメントを削除しました"
    redirect_to post_path(@post)
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment, :post_id)
    end
end