class RemoveColumnImprovementSuggestionToPerfReview < ActiveRecord::Migration[5.0]
  def change
  	remove_column :perf_reviews,:improvement_suggestion
  end
end
