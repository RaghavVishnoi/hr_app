class AddColumnExpReportToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :exp_report, :boolean
  end
end
