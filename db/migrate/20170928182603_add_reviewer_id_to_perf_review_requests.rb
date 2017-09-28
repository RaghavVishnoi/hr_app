class AddReviewerIdToPerfReviewRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_review_requests, :reviewer_id, :text
  end
end
