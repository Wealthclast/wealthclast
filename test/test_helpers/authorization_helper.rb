module AuthorizationHelper
  def login
    stub_token_request
    stub_get_profile
    get login_url
    session_state = @controller.session[:state]
    get oauth_callback_url, params: {state: session_state}
  end

  # TODO: Remove duplication with yield
  def login_as(account)
    stub_token_request
    stub_get_profile(uuid: account.uuid)
    get login_url
    session_state = @controller.session[:state]
    get oauth_callback_url, params: {state: session_state}
  end

  def login_error
    get oauth_callback_url, params: {error: "invalid request"}
  end
end
