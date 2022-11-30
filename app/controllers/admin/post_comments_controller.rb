class Admin::PostCommentsController < ApplicationController
  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to admin_user_post_path(params[:user_post_id])
  end
end
