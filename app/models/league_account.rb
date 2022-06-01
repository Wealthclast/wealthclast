class LeagueAccount < ApplicationRecord
  belongs_to :account
  belongs_to :league
  has_many :item_snapshots, dependent: :destroy

  scope :temporary, -> { joins(:league).where.not(league: {ends_at: nil}) }
end
