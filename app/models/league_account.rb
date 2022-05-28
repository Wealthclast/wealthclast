class LeagueAccount < ApplicationRecord
  belongs_to :account
  belongs_to :league
  has_many :item_snapshots, dependent: :destroy
end
