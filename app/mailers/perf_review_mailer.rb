class PerfReviewMailer < ApplicationMailer
	  default from: "rihan4rails@gmail.com"

	  def notify(email,perf_review)
	   	 @perf_review = perf_review
	   	 mail(to: email, subject: "Review Submit: #{@perf_review.created_at.strftime('%d %b,%Y')}")
	  end
end
