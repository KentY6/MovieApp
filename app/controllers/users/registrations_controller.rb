# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "アカウント登録が完了しました"
        puts = "アカウント登録が完了しました"
      else
        puts = "アカウント登録に失敗しました"
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
      if resource.persisted?
        super
        flash[:notice] = "アカウント削除が完了しました"
      else
        flash[:alert] = "アカウント削除に失敗しました"
      end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
