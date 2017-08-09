class AddColumnToExam < ActiveRecord::Migration[5.0]
  def change
    add_column :exams, :cut_off_marks, :numeric
  end
end
