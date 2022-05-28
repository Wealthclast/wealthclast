class ItemSnapshot < ApplicationRecord
  belongs_to :item
  belongs_to :league_account
end
