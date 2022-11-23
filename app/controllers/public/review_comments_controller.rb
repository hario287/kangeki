class Public::ReviewCommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    review_comment = current_user.review_comments.new(review_comment_params)
    review_comment.review_id = @review.id
    if review_comment.save
      flash.now[:notice] = "コメントしました"
      redirect_to review_path(@review)
    else
      render :error
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    flash.now[:alert] = "コメントを削除しました"
    redirect_to review_path(@review)
  end

  private
    def review_comment_params
      params.require(:review_comment).permit(:comment, :review_id)
    end
end