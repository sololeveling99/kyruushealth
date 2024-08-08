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

ActiveRecord::Schema.define(version: 2024_08_07_073840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_in_results", force: :cascade do |t|
    t.bigint "check_in_id"
    t.bigint "questionnaire_id"
    t.json "response", default: {}, null: false
    t.integer "count_1", default: 0, null: false
    t.integer "count_2", default: 0, null: false
    t.integer "count_3", default: 0, null: false
    t.integer "total_score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["check_in_id"], name: "index_check_in_results_on_check_in_id"
    t.index ["questionnaire_id"], name: "index_check_in_results_on_questionnaire_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.string "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
  end

  create_table "questionnaire_questions", force: :cascade do |t|
    t.bigint "questionnaire_id"
    t.bigint "question_id"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_questionnaire_questions_on_question_id"
    t.index ["questionnaire_id", "order"], name: "index_questionnaire_questions_on_questionnaire_id_and_order", unique: true
    t.index ["questionnaire_id"], name: "index_questionnaire_questions_on_questionnaire_id"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_statement", null: false
    t.boolean "severe", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "check_in_results", "check_ins"
  add_foreign_key "check_in_results", "questionnaires"
  add_foreign_key "questionnaire_questions", "questionnaires"
  add_foreign_key "questionnaire_questions", "questions"
end
