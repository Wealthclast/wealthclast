class OAuthRefreshToken < ApplicationRecord
  belongs_to :account
  encrypts :refresh_token

  def expired?
    Time.now.utc > expires_at
  end
end
