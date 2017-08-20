class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
      t.string :subject
      t.string :body
      t.datetime :from_date
      t.datetime :to_date
      t.datetime :employee_accepted_at
      t.datetime :tl_accepted_at
      t.datetime :tm_accepted_at
      t.datetime :hr_accepted_at
      t.datetime :president_accepted_at
      t.integer :assigned_to
      t.integer :employee_id
      t.string :status
      t.timestamps
    end
  end
end
