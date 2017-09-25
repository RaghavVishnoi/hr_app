class CreatePerfReviewCatgs < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_review_catgs do |t|
      t.string :name, unique: true
      t.integer :employee_id

      t.timestamps
    end
    add_index :perf_review_catgs, :employee_id

  end
end
