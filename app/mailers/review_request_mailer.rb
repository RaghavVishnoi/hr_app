class ReviewRequestMailer < ApplicationMailer

  default from: "rihan4rails@gmail.com"

  def notify(email,employee,perf_review_request)
   	 @employee = employee
   	 @perf_review_request = perf_review_request
   	 mail(to: email, subject: "Review Request: #{employee.name}")
  end

end
