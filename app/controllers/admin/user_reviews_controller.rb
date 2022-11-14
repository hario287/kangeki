class Admin::UserReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @review = Review.all.page(params[:page]).per(10)
  end

  def show
    @review = Review.find(params[:id])
    @review_comment =@review.review_comments
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to _path
  end

end
