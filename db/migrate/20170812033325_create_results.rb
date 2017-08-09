class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :employee, foreign_key: true
      t.references :exam, foreign_key: true
      t.integer :obtained_marks
      t.integer :correct_ans
      t.integer :incorrect_ans

      t.timestamps
    end
  end
end
