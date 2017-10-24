class AddColumnCommentToLeaveResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_responses, :comment, :text
  end
end
