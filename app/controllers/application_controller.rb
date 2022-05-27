class ApplicationController < ActionController::Base
  before_action :require_login

  def current_account
    @current_account ||= session[:profile_uuid] &&
      Account.find_by(uuid: session[:profile_uuid])
  end

  def path_of_exile_client
    @_api_client ||= PathOfExile::API.new(access_token: session[:access_token])
  end

  private

  def logged_in?
    current_account.present?
  end

  def require_login
    unless logged_in?
      flash[:error] = I18n.t "authorization.access_denied"
      redirect_to root_path
    end
  end
end
