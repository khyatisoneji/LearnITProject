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

ActiveRecord::Schema.define(version: 2019_06_08_094154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.bigint "user_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "que_jobs", primary_key: ["queue", "priority", "run_at", "job_id"], comment: "3", force: :cascade do |t|
    t.integer "priority", limit: 2, default: 100, null: false
    t.datetime "run_at", default: -> { "now()" }, null: false
    t.bigserial "job_id", null: false
    t.text "job_class", null: false
    t.json "args", default: [], null: false
    t.integer "error_count", default: 0, null: false
    t.text "last_error"
    t.text "queue", default: "", null: false
  end

  create_table "question_schedule_times", force: :cascade do |t|
    t.string "question_time", null: false
    t.bigint "team_id"
    t.index ["team_id"], name: "index_question_schedule_times_on_team_id"
  end

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
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.string "user_name"
    t.string "slack_user_id"
    t.bigint "team_id"
    t.string "timezone"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "question_schedule_times", "teams"
  add_foreign_key "questions", "teams"
  add_foreign_key "users", "teams"
end
