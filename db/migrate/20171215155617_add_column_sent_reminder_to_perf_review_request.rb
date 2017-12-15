class AddColumnSentReminderToPerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_review_requests, :sent_reminder, :boolean,default: false
  end
end
