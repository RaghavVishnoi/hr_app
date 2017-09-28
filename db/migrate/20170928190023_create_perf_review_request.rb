class CreatePerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_review_requests do |t|
      t.integer :reviewee_id
      t.integer :employee_id
      t.text :reviewer_id
      t.boolean :flag
    end
  end
end
