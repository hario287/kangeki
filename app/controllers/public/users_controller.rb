class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def index
  end

  def edit
  end
end
