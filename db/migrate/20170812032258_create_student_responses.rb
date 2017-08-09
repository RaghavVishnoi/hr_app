class CreateStudentResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.references :question, foreign_key: true
      t.string :answer
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
