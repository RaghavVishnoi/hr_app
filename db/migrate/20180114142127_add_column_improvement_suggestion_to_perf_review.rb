class AddColumnImprovementSuggestionToPerfReview < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_reviews, :improvement_suggestion, :text
  end
end
