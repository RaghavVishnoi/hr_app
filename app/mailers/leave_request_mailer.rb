class LeaveRequestMailer < ApplicationMailer
	default from: "rihan4rails@gmail.com"

  def leave_email(email,leave_request)
   	 @user_email = email
   	 @leave_request = leave_request
  	 @employee = @leave_request.employee
  	 @cover = @leave_request.cover
   	 mail(to: @user_email, subject: "Leave Request from #{@employee.first_name} #{@employee.last_name}")
  end

  def update_status_email(leave_response,reporting_email)
  	@reporting_email = reporting_email
  	@leave_response = leave_response
  	@leave_request = @leave_response.leave_request
  	@request_owner = @leave_response.leave_request.employee
  	@request_approved_by = @leave_response.employee.name
  	@cover = @leave_request.cover
  	mail(to: @reporting_email, subject: "Leave Request Approved by #{@request_owner.first_name} #{@request_owner.last_name}")
  end	
end
