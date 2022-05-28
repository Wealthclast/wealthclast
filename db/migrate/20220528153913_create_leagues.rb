class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :realm
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :description
      t.boolean :private, null: false, default: false
      t.string :icon
      t.string :cover
      t.string :slug

      t.timestamps
    end
    add_index :leagues, :private
  end
end
