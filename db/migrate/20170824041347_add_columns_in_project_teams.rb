class AddColumnsInProjectTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :project_teams, :team_leader_id, :integer
    add_column :project_teams, :team_manager_id, :integer
  end
end
