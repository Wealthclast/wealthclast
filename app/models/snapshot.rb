class Snapshot < ApplicationRecord
  belongs_to :league_account
  has_many :item_snapshots, dependent: :destroy
end
