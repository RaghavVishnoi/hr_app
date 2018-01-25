class AddColumnStartDateToEmployeeHours < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_hours, :start_date, :datetime
  end
end
