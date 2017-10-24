class AddReportingManagerIdToLeaveRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_requests, :reporting_manager_id, :integer,default: 1
  end
end
