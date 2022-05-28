class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.belongs_to :league, null: false, foreign_key: true
      t.string :icon, null: false

      t.timestamps
    end
  end
end
