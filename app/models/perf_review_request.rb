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
  
  def reviews(reviewer_id)
    data = {}
    if self.perf_reviews.present?
      review = self.perf_reviews.find_by(reviewer_id: reviewer_id)
      if review.present?
        data[:review_date] = review.created_at.strftime("%d %b,%Y")
        data[:review_avg] = review.avg
      else
        data[:review_date] = 'Not Available'
        data[:review_avg] = 'Not Available'
      end
    else
      data[:review_date] = 'Pending'
      data[:review_avg] = 'Pending'
    end
    data
  end

end

