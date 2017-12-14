class AddColumnsToPerformanceReviewRequests < ActiveRecord::Migration[5.0]
  def change
  	add_column :perf_review_requests,:job_title,:string
  	add_column :perf_review_requests,:time_in_position,:string
  	add_column :perf_review_requests,:last_appraisal,:string
  	add_column :perf_review_requests,:first_prepared,:datetime
  	add_column :perf_review_requests,:hiring_date,:datetime
  end
end
