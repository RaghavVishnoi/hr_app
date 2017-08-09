class ChagneDefaultInExam < ActiveRecord::Migration[5.0]
  def change
    change_column :exams, :state, :boolean, default: nil
  end
end
