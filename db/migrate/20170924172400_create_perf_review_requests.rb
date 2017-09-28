class CreatePerfReviewRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_review_requests do |t|
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.boolean :flag
      t.float :avg
      t.integer :employee_id

      t.timestamps
    end
    add_index :perf_review_requests, :reviewee_id
    add_index :perf_review_requests, :employee_id
  end
end
