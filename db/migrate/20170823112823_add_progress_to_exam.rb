class AddProgressToExam < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :completed_at, :datetime, default: nil
    add_column :results, :started_at, :datetime, default: nil
  end
end
