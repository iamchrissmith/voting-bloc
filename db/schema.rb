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

ActiveRecord::Schema.define(version: 20170528211944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ballots", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "election_id"
    t.index ["election_id"], name: "index_ballots_on_election_id"
    t.index ["user_id"], name: "index_ballots_on_user_id"
  end

  create_table "elections", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "topic"
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.integer "role", default: 0
    t.string "email"
    t.text "profile"
  end

  add_foreign_key "ballots", "elections"
  add_foreign_key "ballots", "users"
end
