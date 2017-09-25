class CreateQuesAnsws < ActiveRecord::Migration[5.0]
  def change
    create_table :ques_answs do |t|
      t.string :answer
      t.integer :question_id
      t.integer :employee_id

      t.timestamps
    end
    add_index :ques_answs, :question_id
    add_index :ques_answs, :employee_id
  end
end
