class ResultMailer < ApplicationMailer
	default from: "rihan4rails@gmail.com"

  def send_result(result,employees,participant)
   	 @result = result
   	 @participant = participant
   	 employee_email = employees.pluck(:email)
   	 mail(to: employee_email, subject: "Exam Result: #{participant.name}")
  end

 
end
