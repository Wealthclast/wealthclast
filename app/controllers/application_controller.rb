class ApplicationController < ActionController::Base
  before_action :require_login

  def current_user
    if session[:profile_uuid]
      @profile_name = session[:profile_name]
    end
  end

  private

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:error] = I18n.t "authorization.access_denied"
      redirect_to root_path
    end
  end
end
