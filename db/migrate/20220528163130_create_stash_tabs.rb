class CreateStashTabs < ActiveRecord::Migration[7.0]
  def change
    create_table :stash_tabs do |t|
      t.string :_id, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.belongs_to :league_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
