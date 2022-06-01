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
      response = PathOfExile::OAuth.get_access_token(code: params[:code])
      session[:access_token] = response["access_token"]

      profile = path_of_exile_client.profile
      session[:profile_uuid] = profile["uuid"]

      @current_account = Account.find_or_create_by(uuid: profile["uuid"]) do |a|
        a.name = profile["name"]
        a.realm = profile["realm"]
        a.guild = profile["guild"]["name"]
        a.locale = profile["locale"]
      end

      OAuthRefreshToken.find_or_create_by(account: @current_account) do |t|
        t.refresh_token = response["refresh_token"]
        t.expires_at = Time.now.utc + PathOfExile::OAuth::REFRESH_TOKEN_TIMESPAN
      end

      # if LeagueAccount.find(account: @current_account)
      # check for new chars in new leagues
      # else
      # First signup
      # TODO: fill progress bar in the view
      # SignupStarter.new(
      #   access_token: session[:access_token]
      # ).call(@current_account)
      # end

      redirect_to dashboard_path
    end
  end

  def destroy
    PathOfExile::OAuth.revoke_token(token: session[:access_token])
    reset_session
    @current_account = nil
    redirect_to root_path
  end
end
