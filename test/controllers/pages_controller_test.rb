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
end
