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

ActiveRecord::Schema[7.2].define(version: 2024_08_27_031707) do
  create_table "death_means", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "#<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x00007f29215a5e78>"
    t.string "description"
    t.index ["name"], name: "index_death_means_on_name", unique: true
  end

  create_table "import_logs", force: :cascade do |t|
    t.string "source_file", null: false
    t.boolean "imported", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_file"], name: "index_import_logs_on_source_file", unique: true
  end

  create_table "kills", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "killer_id"
    t.integer "killed_id", null: false
    t.integer "death_mean_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["death_mean_id"], name: "index_kills_on_death_mean_id"
    t.index ["killed_id"], name: "index_kills_on_killed_id"
    t.index ["killer_id"], name: "index_kills_on_killer_id"
    t.index ["match_id"], name: "index_kills_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches_players", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "player_id", null: false
    t.integer "assigned_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_used"
    t.index ["match_id"], name: "index_matches_players_on_match_id"
    t.index ["player_id"], name: "index_matches_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_players_on_name", unique: true
  end

  add_foreign_key "kills", "death_means"
  add_foreign_key "kills", "matches"
  add_foreign_key "kills", "players", column: "killed_id"
  add_foreign_key "kills", "players", column: "killer_id"
  add_foreign_key "matches_players", "matches"
  add_foreign_key "matches_players", "players"
end
