class ChangeDatetimeToBoolean < ActiveRecord::Migration[5.0]
   def up
   change_column :employee_usage_logs, :logs_time, :string
  end

  def down
   change_column :employee_usage_logs, :logs_time, :datetime
  end
end
