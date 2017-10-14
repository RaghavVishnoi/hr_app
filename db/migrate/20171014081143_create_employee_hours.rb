class CreateEmployeeHours < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_hours do |t|
    	t.float :available_sick_hours
    	t.float :initial_sick_hours
    	t.float :available_vocation_hours
    	t.float :initial_vocation_hours
    	t.integer :employee_id
        t.timestamps
    end
    add_foreign_key :employee_hours,:employees
  end
end
