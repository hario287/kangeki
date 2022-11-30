class Admin::ReviewCommentsController < ApplicationController
  def destroy
    comment = ReviewComment.find(params[:id])
    comment.destroy
    redirect_to admin_user_review_path(params[:user_review_id])
  end
end
