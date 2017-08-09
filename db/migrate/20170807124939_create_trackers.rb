class CreateTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :trackers do |t|
      t.string :title
      t.string :description
      t.references :project, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
