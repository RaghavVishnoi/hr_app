class AddColumnsToLeaveRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :leave_requests,:leave_hour_type,:string
  	add_column :leave_requests,:sick_hour_usage,:float
  	add_column :leave_requests,:vocation_hour_usage,:float
  	add_column :leave_requests,:make_up_time_usage,:float
  end
end
