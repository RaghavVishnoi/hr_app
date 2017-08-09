class AddReferenceToExams < ActiveRecord::Migration[5.0]
  def change
    add_reference :exams, :subject, foreign_key: true
  end
end
