class AddColumnCommentToEmployee < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :comment, :text
  end
end
