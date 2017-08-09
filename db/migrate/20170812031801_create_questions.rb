class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :exam, foreign_key: true
      t.string :question
      t.string :question_type
      t.string :options
      t.string :answer

      t.timestamps
    end
  end
end
