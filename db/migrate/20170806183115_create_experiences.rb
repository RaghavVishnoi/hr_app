class CreateExperiences < ActiveRecord::Migration[5.0]
  def up
    create_table :experiences do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :title
      t.string :description
      t.references :employee, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :experiences
  end
end
