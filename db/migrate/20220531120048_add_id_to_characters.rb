class AddIdToCharacters < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :_id, :string
    add_index :characters, :_id, unique: true
  end
end
