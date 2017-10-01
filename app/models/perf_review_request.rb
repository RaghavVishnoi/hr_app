class PerfReviewRequest < ApplicationRecord
  belongs_to :employee
  has_many :reviewers, class_name: 'PerfReviewReviewer', foreign_key: 'perf_review_request_id'

  def reviewee
    Employee.find(reviewee_id)
  end

  def reviewer_name
    self.reviewers.pluck(:reviewer_id).map { | id | Employee.find(id).name }.to_sentence
  end

  def reviewers
    PerfReviewReviewer.where(perf_review_request_id: self.id)
  end
  #
  # def self.already_exists?(reviewee_id, reviewer_id)
  #   requests = PerfReviewRequest.where(reviewee_id)
  #   requests.each do |request|
  #     request.reviewers.pluck(:reviewer_id)
  # end

end

