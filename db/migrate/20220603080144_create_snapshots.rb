class CreateSnapshots < ActiveRecord::Migration[7.0]
  def change
    create_table :snapshots do |t|
      t.belongs_to :league_account, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
