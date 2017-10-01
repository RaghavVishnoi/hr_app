class AddRequestIdToPerfReview < ActiveRecord::Migration[5.0]
  def change
    add_column :perf_reviews, :request_id, :integer
  end
end
