class LeaveRequestMailer < ApplicationMailer
	default from: "rihan4rails@gmail.com"

  def leave_email(email,lev_id)
   	 @user_email = email
   	 @leave_id = lev_id
  	 @leave=Leave.find(@leave_id)
  	 @employee=@leave.employee
  	 @as_emp=Employee.find(@leave.assigned_to)
   	 mail(to: @user_email, subject: 'Leave Request from #{@employee.first_name} #{@employee.last_name}')
  end
end
