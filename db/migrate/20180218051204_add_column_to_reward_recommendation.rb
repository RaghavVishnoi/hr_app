class AddColumnToRewardRecommendation < ActiveRecord::Migration[5.0]
  def change
    add_column :reward_recommendations, :team_lead_id, :integer
    add_column :reward_recommendations, :team_manager_id, :integer
    add_foreign_key :reward_recommendations, :employees, column: :team_lead_id
    add_foreign_key :reward_recommendations, :employees,column: :team_manager_id
  end
end
