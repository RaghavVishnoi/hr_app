class ChangeColumnLastAppraisalToPerfReviewRequest < ActiveRecord::Migration[5.0]
  def change
  	remove_column :perf_review_requests,:last_appraisal
  	add_column :perf_review_requests,:last_appraisal,:date
  end
end
