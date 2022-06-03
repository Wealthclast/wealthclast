class Account < ApplicationRecord
  has_one :oauth_refresh_token, dependent: :destroy
  has_many :league_accounts, dependent: :destroy
  has_many :characters, dependent: :destroy

  delegate :refresh_token, to: :oauth_refresh_token

  def leagues_playing_from_chars
    characters.distinct.pluck(:league)
  end

  def private_leagues_from_chars
    leagues_playing_from_chars - League.not_private.distinct.pluck(:name)
  end

  # Does the account has any private league that is not saved
  def any_private_league_not_saved?
    private_leagues_not_saved.any?
  end

  def private_leagues_not_saved
    private_leagues_from_chars - League.where(private: true).distinct.pluck(:name)
  end
end
