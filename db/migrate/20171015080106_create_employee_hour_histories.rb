class CreateEmployeeHourHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_hour_histories do |t|
    	t.datetime :start_date
    	t.datetime :end_date
    	t.float :sick_hours
    	t.float :vocation_hours
    	t.integer :employee_hour_id
        t.timestamps
    end
    add_foreign_key :employee_hour_histories,:employee_hours
  end
end
