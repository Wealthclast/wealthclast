require "test_helper"
require_relative "../../../lib/path_of_exile/api"

class PathOfExile::APITest < ActiveSupport::TestCase
  setup do
    @random_string ||= SecureRandom.base58
    @client ||= PathOfExile::API.new(access_token: @random_string)
  end

  test "should build the expected GET /profile request" do
    stub_get_profile
    @client.profile

    assert_requested(
      :get,
      "https://api.pathofexile.com/profile",
      headers: {
        "User-Agent" => USER_AGENT,
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@random_string}"
      },
      times: 1
    )
  end
end
