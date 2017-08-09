class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.datetime :from_date
      t.datetime :to_date
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
