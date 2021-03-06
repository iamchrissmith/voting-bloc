class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_candidate?
    current_user && current_user.candidate?
  end

  def require_user
    redirect_to login_path unless current_user
  end
end
