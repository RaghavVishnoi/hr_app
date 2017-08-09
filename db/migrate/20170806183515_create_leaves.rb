class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
      t.string :subject
      t.string :body
      t.datetime :from_date
      t.datetime :to_date
      t.string :acceptable_type
      t.integer :acceptable_id

      t.timestamps
    end
  end
end
