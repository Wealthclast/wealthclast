require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root should be rendered by Pages#index" do
    assert_routing "/", controller: "pages", action: "index"
  end

  test "/dashboard routing" do
    assert_routing "/dashboard", controller: "pages", action: "dashboard"
  end

  test "GET /" do
    get root_url
    assert_response :success
    assert_select "h1", "Pages#index"
  end

  test "index should not have a route" do
    assert_raises(NameError) do
      get index_url
    end
  end

  test "dashboard should redirect to root when not authorized" do
    get dashboard_url
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Pages#index"
    assert_equal I18n.t("authorization.access_denied"), flash[:error]
  end

  test "dashboard should render correctly when authorized" do
    login
    get dashboard_url
    assert_response :success
    assert_select "h1", "Pages#dashboard"
  end
end
