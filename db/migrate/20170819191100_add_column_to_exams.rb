class AddColumnToExams < ActiveRecord::Migration[5.0]
  def change
    add_reference :exams, :team, foreign_key: true
  end
end
