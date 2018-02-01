class CreateRewardRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :reward_recommendations do |t|
    	t.integer :recommended_employee_id
    	t.integer :employee_id
    	t.text    :comment
    	t.string :recommendation_month
    	t.string :recommendation_year
    	t.string :previous_awarded_month
    	t.string :previous_awarded_year
    	t.string  :status
        t.timestamps
    end
    add_foreign_key :reward_recommendations,:employees,column: :recommended_employee_id
    add_foreign_key :reward_recommendations,:employees
  end
end
