class CreateLeaveWorkAssigns < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_work_assigns do |t|
      t.references :leave, foreign_key: true
      t.string :assign_to
      t.references :employee, foreign_key: true
      t.date :assign_date

      t.timestamps
    end
  end
end
