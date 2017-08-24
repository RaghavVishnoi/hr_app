class AddEntryTypeToEmployeeUsageLog < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_usage_logs, :entry_type, :string
  end
end
