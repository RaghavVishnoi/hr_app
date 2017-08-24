class CreateEmployeeUsageLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_usage_logs do |t|
      t.references :employee, foreign_key: true
      t.datetime :logs_time

      t.timestamps
    end
  end
end
