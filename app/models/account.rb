class Account < ApplicationRecord
  has_one :oauth_refresh_token, dependent: :destroy
  has_many :characters, dependent: :destroy
end
