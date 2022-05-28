# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_28_155032) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name"
    t.string "realm"
    t.string "guild"
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_accounts_on_uuid", unique: true
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "league", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_characters_on_account_id"
  end

  create_table "league_accounts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "league_id", null: false
    t.boolean "idle", default: false, null: false
    t.datetime "last_sync_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_league_accounts_on_account_id"
    t.index ["league_id"], name: "index_league_accounts_on_league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", null: false
    t.string "realm"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "description"
    t.boolean "private", default: false, null: false
    t.string "icon"
    t.string "cover"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_leagues_on_name", unique: true
    t.index ["private"], name: "index_leagues_on_private"
  end

  create_table "oauth_refresh_tokens", force: :cascade do |t|
    t.string "refresh_token", null: false
    t.datetime "expires_at", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_oauth_refresh_tokens_on_account_id", unique: true
  end

  add_foreign_key "characters", "accounts"
  add_foreign_key "league_accounts", "accounts"
  add_foreign_key "league_accounts", "leagues"
  add_foreign_key "oauth_refresh_tokens", "accounts"
end
