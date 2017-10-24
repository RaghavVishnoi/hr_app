class AddPresidentIdToLeaveRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :leave_requests,:president_id,:integer,index: true,default: 1
  end
end
