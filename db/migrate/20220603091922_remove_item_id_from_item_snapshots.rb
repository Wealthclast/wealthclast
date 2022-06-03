class RemoveItemIdFromItemSnapshots < ActiveRecord::Migration[7.0]
  def change
    remove_index :item_snapshots, column: [:item_id, :league_account_id]
    remove_belongs_to :item_snapshots, :item, foreign_key: true, index: true
  end
end
