class ChangeColumnTypePerfReviewRequests < ActiveRecord::Migration[5.0]
  def change
    change_column :perf_review_requests, :reviewer_id, :text
  end
end
