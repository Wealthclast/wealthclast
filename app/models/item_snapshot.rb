class ItemSnapshot < ApplicationRecord
  belongs_to :league_account
  belongs_to :snapshot
end
