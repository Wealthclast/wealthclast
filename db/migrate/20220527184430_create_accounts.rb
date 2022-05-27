class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :uuid, null: false
      t.string :name
      t.string :realm
      t.string :guild
      t.string :locale

      t.timestamps
    end
    add_index :accounts, :uuid, unique: true
  end
end
