class PerfReviewRequest < ApplicationRecord
  belongs_to :employee
  has_many :perf_reviews, class_name: 'PerfReview', foreign_key: 'request_id'
  has_many :reviewers, class_name: 'PerfReviewReviewer', foreign_key: 'reviewer_id'

  def reviewee
    Employee.find(reviewee_id)
  end

  def reviewer_name
    self.reviewers.pluck(:reviewer_id).map { | id | Employee.find(id).name }.to_sentence
  end

  def self.notify_review_request
      perf_review_requests = PerfReviewRequest.where('due_date >= ?  AND sent_reminder = ?',Date.today,false)
      perf_review_requests.each do |perf_review_request|
        if perf_review_request.due_date <= (Date.today + 1.day)
          reviewers = perf_review_request.reviewers
          reviewers.each do |reviewer|
            reviewee = Employee.find(perf_review_request.reviewee_id)
            ReviewRequestMailer.notify(reviewer.employee.email,reviewee,perf_review_request).deliver_now
          end
          perf_review_request.update(sent_reminder: true) 
        end
      end
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

