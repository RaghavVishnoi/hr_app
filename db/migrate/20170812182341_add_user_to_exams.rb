class AddUserToExams < ActiveRecord::Migration[5.0]
  def change
    add_reference :exams, :employee, foreign_key: true
  end
end
