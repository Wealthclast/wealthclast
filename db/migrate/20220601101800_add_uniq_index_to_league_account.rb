class AddUniqIndexToLeagueAccount < ActiveRecord::Migration[7.0]
  def change
    add_index :league_accounts, [:account_id, :league_id], unique: true
  end
end
