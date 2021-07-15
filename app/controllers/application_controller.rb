class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ユーザーとしてログインに成功しました"
      reservations_path
    elsif current_mentor
      flash[:notice] = "メンターとしてログインに成功しました"
      reservations_path
    end
  end

  def current_user?
    current_user ? true : false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(job_id pref_id name name_kana nickname phone birthday gender work_place self_introduction))
  end
end
