require "test_helper"
require_relative "../../../lib/path_of_exile/oauth"

class PathOfExile::OAuthTest < ActiveSupport::TestCase
  setup do
    @random_string ||= SecureRandom.base58
    @escaped_scopes ||= CGI.escape(PathOfExile::OAuth::SCOPES)
  end

  test "should build the expected authorization code grant url" do
    url = PathOfExile::OAuth.authorization_code_grant_url(state: @random_string)
    expected_url = "https://www.pathofexile.com/oauth/authorize?" \
      "client_id=#{Rails.application.credentials.oauth_id}" \
      "&prompt=consent" \
      "&redirect_uri=https%3A%2F%2Fwealthclast.com%2Fauth%2Fpathofexile%2Fcallback" \
      "&response_type=code" \
      "&scope=#{@escaped_scopes}" \
      "&state=#{@random_string}"

    assert_equal url, expected_url
  end

  test "should build the expected token request" do
    stub_token_request
    expected_body = "client_id=#{Rails.application.credentials.oauth_id}" \
      "&client_secret=#{Rails.application.credentials.oauth_secret}" \
      "&grant_type=authorization_code" \
      "&code=#{@random_string}" \
      "&redirect_uri=" \
      "&scope=#{@escaped_scopes}"
    PathOfExile::OAuth.get_access_token(code: @random_string)

    assert_requested(
      :post,
      "https://www.pathofexile.com/oauth/token",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/x-www-form-urlencoded"
      },
      body: expected_body,
      times: 1
    )
  end

  test "should build the expected revoke token request" do
    stub_revoke_token
    PathOfExile::OAuth.revoke_token(token: @random_string)

    assert_requested(
      :post,
      "https://www.pathofexile.com/oauth/token/revoke",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/x-www-form-urlencoded"
      },
      body: "token=#{@random_string}&scope=oauth%3Arevoke",
      times: 1
    )
  end
end
