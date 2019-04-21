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

ActiveRecord::Schema.define(version: 2019_04_21_081017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_questions_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "slack_team_id"
    t.string "name"
    t.boolean "active", default: true
    t.string "domain"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bot_user_id"
    t.string "activated_user_id"
    t.string "activated_user_access_token"
    t.string "question_time", default: "10:00", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "nickname"
    t.string "slack_user_id"
    t.bigint "team_id"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "questions", "teams"
  add_foreign_key "users", "teams"
end
