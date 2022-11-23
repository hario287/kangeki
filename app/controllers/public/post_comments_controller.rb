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
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:alert] = "コメントを削除しました"
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:comment, :post_id)
    end
end