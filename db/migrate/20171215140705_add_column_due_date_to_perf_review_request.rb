class AddColumnDueDateToPerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_review_requests, :due_date, :datetime
  end
end
