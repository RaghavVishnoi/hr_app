class CreatePerfReviewReviewers < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_review_reviewers do |t|
      t.integer :perf_review_request_id
      t.integer :reviewer_id
      t.boolean :flag
    end
  end
end
