class CreateIssues < ActiveRecord::Migration[5.0]
  def up
    create_table :issues do |t|
      t.string :title
      t.string :description
      t.integer :creator_id
      t.integer :solved_by
      t.integer :status, default: 1

      t.timestamps
    end
  end

  def down
    drop_table :issues
  end
end
