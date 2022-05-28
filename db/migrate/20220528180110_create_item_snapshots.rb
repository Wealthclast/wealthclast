class CreateItemSnapshots < ActiveRecord::Migration[7.0]
  def change
    create_table :item_snapshots do |t|
      t.belongs_to :item, null: false, foreign_key: true
      t.belongs_to :league_account, null: false, foreign_key: true
      t.integer :stack_size, null: false, default: 0

      t.timestamps
    end

    add_index :item_snapshots, [:item_id, :league_account_id]
  end
end
