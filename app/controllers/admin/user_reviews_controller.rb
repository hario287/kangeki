class Admin::UserReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @review = Review.all.page(params[:page]).per(10)
    @reviews = Review.all
    @tag_list = Tag.all
  end

  def show
    @review = Review.find(params[:id])
    @user = User.find(@review.user.id)
    @review_comment = @review.review_comments
    @review_tags = @review.tags
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_user_reviews_path
  end
end
