require "path_of_exile/oauth"
require "path_of_exile/api"

class AuthorizationController < ApplicationController
  skip_before_action :require_login, only: [:new, :callback]

  def new
    session[:state] = SecureRandom.uuid
    redirect_to(
      PathOfExile::OAuth.authorization_code_grant_url(state: session[:state]),
      allow_other_host: true
    )
  end

  def callback
    if params[:error]
      flash[:error] = I18n.t "authorization.login_failed"

      redirect_to root_path
    elsif session[:state].present? && params[:state] == session[:state]
      response = PathOfExile::OAuth.get_access_token(code: params[:code]).json
      session[:access_token] = response["access_token"]
      session[:refresh_token] = response["refresh_token"]

      profile = path_of_exile_client.profile
      session[:profile_uuid] = profile["uuid"]
      session[:profile_name] = profile["name"]

      redirect_to dashboard_path
    end
  end
end
