class AddColumnToStudentResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :correct_ans, :boolean
  end
end
