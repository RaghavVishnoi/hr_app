class CreatePerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_review_requests do |t|
      t.integer :reviewee_id
      t.integer :employee_id
      t.boolean :flag
    end
    add_index :perf_review_requests, :employee_id
    add_index :perf_review_requests, :reviewee_id
  end
end
