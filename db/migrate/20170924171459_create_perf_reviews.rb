class CreatePerfReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :perf_reviews do |t|
      t.string :name
      t.integer :employee_id
      t.string :time_in_position
      t.string :job_title
      t.date :last_appraisal
      t.string :team_leader
      t.date :first_prepared
      t.date :hiring_date
      t.string :prepared_by
      t.text :catg_reviews
      t.float :avg
      t.integer :reviewer_id

      t.timestamps
    end
    add_index :perf_reviews, :employee_id
    add_index :perf_reviews, :reviewer_id
  end
end
