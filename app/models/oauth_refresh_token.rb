class OAuthRefreshToken < ApplicationRecord
  belongs_to :account

  def expired?
    Time.now.utc > expires_at
  end
end
