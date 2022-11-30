class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]

    if @range == "ユーザー"
      @user = User.looks(params[:search], params[:word])
    elsif @range == "レビュー"
      @reviews = Review.looks(params[:search], params[:word]).page(params[:page])
    elsif @range == "談話室"
      @posts = Post.looks(params[:search], params[:word]).page(params[:page])
    else
    end
  end
end
