class CreateProjectTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :project_teams do |t|
      t.string :name
      t.references :project

      t.timestamps
    end
  end
end
