class DropColumnReviewerIdInPerfReviewRequests < ActiveRecord::Migration[5.0]
  def change
    remove_column :perf_review_requests, :reviewer_id
  end
end
