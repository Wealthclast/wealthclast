class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.belongs_to :account, null: false, index: true, foreign_key: true
      t.string :league, null: false
      # this is currently not being returned by the API
      # TODO: check with them if the docs are outdated
      # t.boolean :current, null: false
      # t.boolean :expired, null: false
      # t.boolean :deleted, null: false

      t.timestamps
    end
  end
end
