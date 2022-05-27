class Account < ApplicationRecord
  has_one :oauth_refresh_tokens, dependent: :destroy
end
