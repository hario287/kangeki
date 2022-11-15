class Admin::ReviewCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @review_comments = ReviewComment.page(params[:page])
  end

  def destroy
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy
    redirect_to request.referer, alert: "コメントを削除しました"
  end

end
