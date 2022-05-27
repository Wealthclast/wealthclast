require "test_helper"

class AuthorizationControllerTest < ActionDispatch::IntegrationTest
  test "routing" do
    assert_routing "/login", controller: "authorization", action: "new"
  end

  test "GET /login should redirect to pathofexile.com" do
    get login_url
    assert_redirected_to %r{\Ahttps://www.pathofexile.com/oauth/authorize}
  end
end
