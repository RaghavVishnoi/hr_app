class PerfReviewReviewer < ApplicationRecord
    belongs_to :perf_review_request
    after_create :send_notification
    belongs_to :employee,class_name: 'Employee',foreign_key: 'reviewer_id'

    def employee
      Employee.find(reviewer_id)
    end

    def reviewer
      Employee.find(reviewer_id)
    end

    private
    def send_notification
        Notification.add("New Review Request","","/request/#{self.perf_review_request_id}/send_review",self.reviewer_id,"perf_review_request")
    	reviewee = Employee.find(self.perf_review_request.reviewee_id)
    	#ReviewRequestMailer.notify(self.employee.email,reviewee,self.perf_review_request).deliver_now
    end


end
