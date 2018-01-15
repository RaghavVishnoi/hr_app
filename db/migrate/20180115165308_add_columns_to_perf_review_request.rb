class AddColumnsToPerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :perf_review_requests,:last_reviewed,:datetime
  	add_column :perf_review_requests,:created_at,:datetime
  end
end
