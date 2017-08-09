class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :description
      t.integer :creator_id
      t.integer :solved_by

      t.timestamps
    end
  end
end
