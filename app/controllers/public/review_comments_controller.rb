class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_user!, unless: :admin_signed_in?

  def create
    @review = Review.find(params[:review_id])
    @review_comment = current_user.review_comments.new(review_comment_params)
    @review_comment.review_id = @review.id
    if @review_comment.save
      @review_comment = ReviewComment.new(user: current_user)
      flash.now[:notice] = "コメントしました"
    else
      flash.now[:notice] = "コメントを入力してください"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    review_comment = ReviewComment.find(params[:id])
    review_comment.destroy
    flash.now[:alert] = "コメントを削除しました"
    render :destroy
  end

  private
    def review_comment_params
      params.require(:review_comment).permit(:comment, :review_id)
    end
end