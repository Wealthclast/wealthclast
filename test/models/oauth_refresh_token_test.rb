require "test_helper"
require_relative "../../lib/path_of_exile/oauth"

class OAuthRefreshTokenTest < ActiveSupport::TestCase
  test "expired?" do
    token = OAuthRefreshToken.create(
      account_id: SecureRandom.uuid,
      refresh_token: SecureRandom.base58,
      expires_at: Time.now.utc + PathOfExile::OAuth::REFRESH_TOKEN_TIMESPAN
    )
    assert_not token.expired?
    travel_to 1.second.from_now + PathOfExile::OAuth::REFRESH_TOKEN_TIMESPAN do
      assert_predicate(token, :expired?)
    end
  end
end
