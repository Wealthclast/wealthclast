class LeagueAccount < ApplicationRecord
  belongs_to :account
  belongs_to :league
end
