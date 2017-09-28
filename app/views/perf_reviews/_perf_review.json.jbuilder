json.extract! perf_review, :id, :name, :employee_id, :time_in_position, :job_title, :last_appraisal, :team_leader, :first_prepared, :hiring_date, :prepared_by, :catg_reviews, :avg, :reviewer_id, :created_at, :updated_at
json.url perf_review_url(perf_review, format: :json)
