class AddColumnCatgSuggestionsToPerfReview < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_reviews, :catg_suggestions, :text
  end
end
