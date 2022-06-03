class AddItemNameToItemSnapshots < ActiveRecord::Migration[7.0]
  def change
    add_column :item_snapshots, :item_name, :string
    add_index :item_snapshots, [:league_account_id, :item_name]
  end
end
