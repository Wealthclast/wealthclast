require "path_of_exile/oauth"

class AuthorizationController < ApplicationController
  def new
    session[:state] = SecureRandom.uuid
    redirect_to(
      PathOfExile::OAuth.authorization_code_grant_url(state: session[:state]),
      allow_other_host: true
    )
  end
end
