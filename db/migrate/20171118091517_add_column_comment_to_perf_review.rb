class AddColumnCommentToPerfReview < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_reviews, :comment, :text
  end
end
