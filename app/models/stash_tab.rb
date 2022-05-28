class StashTab < ApplicationRecord
  self.inheritance_column = nil # allow type as column name
  belongs_to :league_account
end
