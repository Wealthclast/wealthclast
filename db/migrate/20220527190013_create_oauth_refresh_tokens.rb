class CreateOAuthRefreshTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :oauth_refresh_tokens do |t|
      t.string :refresh_token, null: false
      t.datetime :expires_at, null: false
      t.belongs_to :account, null: false, index: {unique: true}, foreign_key: true

      t.timestamps
    end
  end
end
