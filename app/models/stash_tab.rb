class StashTab < ApplicationRecord
  self.inheritance_column = nil # allow type as column name
  belongs_to :league_account

  VALID_TYPES = %(NormalStash PremiumStash CurrencyStash Folder)
end
