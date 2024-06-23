class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!, except: [:top, :about]
  # devise機能をを利用する前に実行する
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def after_sign_up_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    user_path(resource) # リダイレクト先を設定する（必要に応じて変更）
  end   
   
  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(resource)
  end   
  
  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "Signed out successfully."
    root_path
  end
  
  # sign_up,inの際にユーザ名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
  end
  
end
