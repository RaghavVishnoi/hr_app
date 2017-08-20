class CreateProjectTeamMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_team_members do |t|
      t.references :employee, foreign_key: true
      t.references :project_team, foreign_key: true

      t.timestamps
    end
  end
end
