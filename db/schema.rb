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

ActiveRecord::Schema.define(version: 20171025112801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "disclosures", force: :cascade do |t|
    t.integer  "employee_id"
    t.boolean  "template"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "employee_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.string   "document_type"
    t.boolean  "template"
    t.index ["employee_id"], name: "index_documents_on_employee_id", using: :btree
  end

  create_table "emp_benefit_docs", force: :cascade do |t|
    t.integer  "employee_id"
    t.boolean  "template"
    t.string   "template_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.index ["employee_id"], name: "index_emp_benefit_docs_on_employee_id", using: :btree
  end

  create_table "employee_hour_histories", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "sick_hours"
    t.float    "vocation_hours"
    t.integer  "employee_hour_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employee_hours", force: :cascade do |t|
    t.float    "available_sick_hours"
    t.float    "initial_sick_hours"
    t.float    "available_vocation_hours"
    t.float    "initial_vocation_hours"
    t.integer  "employee_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "employee_usage_logs", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "logs_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "entry_type"
    t.index ["employee_id"], name: "index_employee_usage_logs_on_employee_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
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
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "role_id"
    t.string   "status",                 default: "active"
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_employees_on_role_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.string   "color"
    t.integer  "employee_id_id"
    t.string   "for_team"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["employee_id_id"], name: "index_events_on_employee_id_id", using: :btree
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
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_experiences_on_employee_id", using: :btree
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "creator_id"
    t.integer  "solved_by"
    t.integer  "status",      default: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "leave_requests", force: :cascade do |t|
    t.datetime "from"
    t.datetime "to"
    t.string   "subject"
    t.text     "description"
    t.boolean  "is_office_wide_meeting"
    t.boolean  "is_staff_meeting"
    t.boolean  "is_client_visit_day"
    t.boolean  "is_client_visit_week"
    t.boolean  "is_client_part"
    t.boolean  "is_special_approval_needed"
    t.boolean  "is_training_schedule"
    t.string   "coverage_plans"
    t.float    "vacation_hours"
    t.float    "sick_hours"
    t.datetime "date_vacation_accrues"
    t.datetime "date_requested_off"
    t.string   "purspose_timeoff"
    t.boolean  "is_make_up_or_sicktime"
    t.integer  "employee_id"
    t.integer  "cover_id"
    t.integer  "team_lead_id"
    t.integer  "team_manager_id"
    t.string   "status"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "leave_hour_type"
    t.float    "sick_hour_usage"
    t.float    "vocation_hour_usage"
    t.float    "make_up_time_usage"
    t.text     "comment"
    t.integer  "reporting_manager_id",       default: 1
    t.integer  "president_id",               default: 1
  end

  create_table "leave_responses", force: :cascade do |t|
    t.integer  "leave_request_id"
    t.integer  "employee_id"
    t.string   "role"
    t.datetime "response_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "comment"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perf_review_catgs", force: :cascade do |t|
    t.string   "name"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employee_id"], name: "index_perf_review_catgs_on_employee_id", using: :btree
  end

  create_table "perf_review_requests", force: :cascade do |t|
    t.integer "reviewee_id"
    t.integer "employee_id"
    t.boolean "flag"
    t.index ["employee_id"], name: "index_perf_review_requests_on_employee_id", using: :btree
    t.index ["reviewee_id"], name: "index_perf_review_requests_on_reviewee_id", using: :btree
  end

  create_table "perf_review_reviewers", force: :cascade do |t|
    t.integer "perf_review_request_id"
    t.integer "reviewer_id"
    t.boolean "flag"
  end

  create_table "perf_reviews", force: :cascade do |t|
    t.string   "name"
    t.integer  "employee_id"
    t.string   "time_in_position"
    t.string   "job_title"
    t.date     "last_appraisal"
    t.string   "team_leader"
    t.date     "first_prepared"
    t.date     "hiring_date"
    t.string   "prepared_by"
    t.text     "catg_reviews"
    t.float    "avg"
    t.integer  "reviewer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "request_id"
    t.index ["employee_id"], name: "index_perf_reviews_on_employee_id", using: :btree
    t.index ["reviewer_id"], name: "index_perf_reviews_on_reviewer_id", using: :btree
  end

  create_table "project_team_members", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "project_team_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["employee_id"], name: "index_project_team_members_on_employee_id", using: :btree
    t.index ["project_team_id"], name: "index_project_team_members_on_project_team_id", using: :btree
  end

  create_table "project_teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "team_leader_id"
    t.integer  "team_manager_id"
    t.index ["project_id"], name: "index_project_teams_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "assigned_to"
    t.string   "client"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ques_answs", force: :cascade do |t|
    t.string   "answer"
    t.integer  "question_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "review_id"
    t.index ["employee_id"], name: "index_ques_answs_on_employee_id", using: :btree
    t.index ["question_id"], name: "index_ques_answs_on_question_id", using: :btree
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

  create_table "review_catg_quests", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_review_catg_quests_on_category_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signatures", force: :cascade do |t|
    t.string   "sign"
    t.integer  "employee_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "sign_file_name"
    t.string   "sign_content_type"
    t.integer  "sign_file_size"
    t.datetime "sign_updated_at"
    t.index ["employee_id"], name: "index_signatures_on_employee_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "switch_days", force: :cascade do |t|
    t.integer  "employee_id"
    t.date     "real_date"
    t.date     "replace_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["employee_id"], name: "index_switch_days_on_employee_id", using: :btree
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

  create_table "tracker_logs", force: :cascade do |t|
    t.integer  "tracker_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracker_id"], name: "index_tracker_logs_on_tracker_id", using: :btree
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

  add_foreign_key "documents", "employees"
  add_foreign_key "employee_hour_histories", "employee_hours"
  add_foreign_key "employee_hours", "employees"
  add_foreign_key "employee_usage_logs", "employees"
  add_foreign_key "employees", "roles"
  add_foreign_key "exams", "employees"
  add_foreign_key "exams", "subjects"
  add_foreign_key "exams", "teams"
  add_foreign_key "experiences", "employees"
  add_foreign_key "leave_requests", "employees"
  add_foreign_key "leave_requests", "employees", column: "cover_id"
  add_foreign_key "leave_requests", "employees", column: "team_lead_id"
  add_foreign_key "leave_requests", "employees", column: "team_manager_id"
  add_foreign_key "leave_responses", "employees"
  add_foreign_key "leave_responses", "leave_requests"
  add_foreign_key "project_team_members", "employees"
  add_foreign_key "project_team_members", "project_teams"
  add_foreign_key "questions", "exams"
  add_foreign_key "responses", "employees"
  add_foreign_key "responses", "questions"
  add_foreign_key "results", "employees"
  add_foreign_key "results", "exams"
  add_foreign_key "switch_days", "employees"
  add_foreign_key "team_members", "employees"
  add_foreign_key "team_members", "teams"
  add_foreign_key "tracker_logs", "trackers"
  add_foreign_key "trackers", "employees"
  add_foreign_key "trackers", "projects"
end
