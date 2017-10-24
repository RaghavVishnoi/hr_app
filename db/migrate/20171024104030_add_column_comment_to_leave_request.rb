class AddColumnCommentToLeaveRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_requests, :comment, :text
  end
end
