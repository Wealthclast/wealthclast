class CreateLeagueAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :league_accounts do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :league, null: false, foreign_key: true
      t.boolean :idle, null: false, default: false
      t.datetime :last_sync_at

      t.timestamps
    end
  end
end
