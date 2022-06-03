class AddSnapshotIdToItemSnapshot < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to(:item_snapshots, :snapshot, foreign_key: true, index: true)
  end
end
