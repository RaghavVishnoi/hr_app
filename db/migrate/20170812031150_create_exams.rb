class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :title
      t.integer :marks
      t.integer :time
      t.boolean :state

      t.timestamps
    end
  end
end
