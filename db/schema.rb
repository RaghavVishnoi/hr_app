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

ActiveRecord::Schema.define(version: 20170823112824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "zipcode"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_employees_on_role_id", using: :btree
  end

  create_table "exams", force: :cascade do |t|
    t.string   "title"
    t.integer  "marks"
    t.integer  "time"
    t.boolean  "state"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "employee_id"
    t.decimal  "cut_off_marks"
    t.integer  "subject_id"
    t.integer  "team_id"
    t.index ["employee_id"], name: "index_exams_on_employee_id", using: :btree
    t.index ["subject_id"], name: "index_exams_on_subject_id", using: :btree
    t.index ["team_id"], name: "index_exams_on_team_id", using: :btree
  end

  create_table "experiences", force: :cascade do |t|
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "creator_id"
    t.integer  "solved_by"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "leaves", force: :cascade do |t|
    t.string   "subject"
    t.string   "body"
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "acceptable_type"
    t.integer  "acceptable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
    t.integer  "applicable_id"
    t.string   "applicable"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "assigned_to"
    t.string   "client"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "exam_id"
    t.string   "question"
    t.string   "question_type"
    t.string   "options"
    t.string   "answer"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "description"
    t.index ["exam_id"], name: "index_questions_on_exam_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "answer"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "correct_ans"
    t.index ["employee_id"], name: "index_responses_on_employee_id", using: :btree
    t.index ["question_id"], name: "index_responses_on_question_id", using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "exam_id"
    t.integer  "obtained_marks"
    t.integer  "correct_ans"
    t.integer  "incorrect_ans"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "status"
    t.datetime "completed_at"
    t.datetime "started_at"
    t.index ["employee_id"], name: "index_results_on_employee_id", using: :btree
    t.index ["exam_id"], name: "index_results_on_exam_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_team_members_on_employee_id", using: :btree
    t.index ["team_id"], name: "index_team_members_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trackers", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "project_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_trackers_on_employee_id", using: :btree
    t.index ["project_id"], name: "index_trackers_on_project_id", using: :btree
  end

  add_foreign_key "employees", "roles"
  add_foreign_key "exams", "employees"
  add_foreign_key "exams", "subjects"
  add_foreign_key "exams", "teams"
  add_foreign_key "questions", "exams"
  add_foreign_key "responses", "employees"
  add_foreign_key "responses", "questions"
  add_foreign_key "results", "employees"
  add_foreign_key "results", "exams"
  add_foreign_key "team_members", "employees"
  add_foreign_key "team_members", "teams"
  add_foreign_key "trackers", "employees"
  add_foreign_key "trackers", "projects"
end
