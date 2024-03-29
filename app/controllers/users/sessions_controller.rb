# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "ログインに成功しました"
        puts "ログインに成功しました"
      else
        puts "ログインに失敗しました"
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
    flash[:notice] = "ログアウトに成功しました"
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
