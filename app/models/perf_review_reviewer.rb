class PerfReviewReviewer < ApplicationRecord
    belongs_to :perf_review_request

    def employee
      Employee.find(reviewer_id)
    end

    def reviewer
      Employee.find(reviewer_id)
    end


end
