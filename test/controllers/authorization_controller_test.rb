require "test_helper"

class AuthorizationControllerTest < ActionDispatch::IntegrationTest
  test "routing" do
    assert_routing "/login", controller: "authorization", action: "new"
    assert_routing "/auth/pathofexile/callback", controller: "authorization",
      action: "callback"
    assert_routing "/logout", controller: "authorization", action: "destroy"
  end

  test "GET /login should redirect to pathofexile.com" do
    get login_url
    assert_redirected_to %r{\Ahttps://www.pathofexile.com/oauth/authorize}
  end

  test "callback should render error when params contains error" do
    get oauth_callback_url, params: {error: "invalid request"}
    assert_equal I18n.t("authorization.login_failed"), flash[:error]
  end

  test "callback should set access tokens as expected" do
    login
    session = @controller.session
    assert_not_nil session[:access_token]
  end

  test "callback should set profile data as expected" do
    login
    session = @controller.session
    assert_not_nil session[:profile_uuid]
  end

  test "callback should create an Account when not found" do
    assert_difference("Account.count") do
      login
    end

    assert_redirected_to dashboard_url
  end

  test "callback should create an OAuthRefreshToken when not found" do
    assert_difference("OAuthRefreshToken.count") do
      login
    end

    assert_redirected_to dashboard_url
  end

  test "callback should not create an Account when found" do
    assert_no_difference("Account.count") do
      login_as(accounts(:one))
    end

    assert_redirected_to dashboard_url
  end

  test "callback should not create an OAuthRefreshToken when found" do
    assert_no_difference("OAuthRefreshToken.count") do
      login_as(accounts(:one))
    end

    assert_redirected_to dashboard_url
  end

  test "callback should redirect to dashboard on success" do
    login
    assert_redirected_to dashboard_url
  end

  test "destroy should remove access_token from session" do
    login
    assert_not_nil @controller.session[:access_token]
    stub_revoke_token
    get logout_url
    assert_nil @controller.session[:access_token]
  end

  test "destroy should redirect to root" do
    stub_revoke_token
    get logout_url
    assert_redirected_to root_url
  end
end
