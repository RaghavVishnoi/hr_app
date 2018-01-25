class AddColumnMultiplierToEmployeeHours < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_hours, :sick_hours_multiplier, :float
    add_column :employee_hours, :vocation_hours_multiplier, :float
  end
end
