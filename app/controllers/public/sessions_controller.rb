# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
 before_action :user_state, only: [:create]

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  # ゲストユーザー
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "GuestUser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  protected
  # 退会しているかを判断するメソッド
  def user_state
    @user = Userr.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
      redirect_to new_user_registration_path, notice: "退会済みです。"
    else
    end
end

