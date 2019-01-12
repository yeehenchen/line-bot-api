# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_12_132602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "amount"
    t.integer "num_guess"
    t.bigint "player_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_bets_on_game_id"
    t.index ["player_id"], name: "index_bets_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "winNum"
    t.string "roomId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.string "winner"
  end

  create_table "links", force: :cascade do |t|
    t.string "word"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "userId"
    t.string "displayName"
    t.string "pictureUrl"
  end

  add_foreign_key "bets", "games"
  add_foreign_key "bets", "players"
end
