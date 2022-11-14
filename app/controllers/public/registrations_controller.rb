# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  before_action :ensure_general_user, only: [:update, :destroy]

  def ensure_general_user
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーの変更・削除はできません"
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end
