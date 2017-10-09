class LeaveResponse < ApplicationRecord

	attr_accessor :reporting_manager_action

	after_create :notify_users

	belongs_to :leave_request
	belongs_to :employee

	private
		def notify_users
			reporting_email = ""
			status = ""
			case self.employee.role.role
			when 'team_leader'
				reporting_email = self.leave_request.team_manager.email
				if reporting_manager_action == "approved"
					status = "lead_approved"
				else
					status = "lead_rejected"
				end
			when "team_manager"
				reporting_email = Employee.find_by_role_id(Role.find_by_role("hr"))
				if reporting_manager_action == "approved"
					status = "manager_approved"
				else
					status = "manager_rejected"
				end
			when 'hr'
				reporting_email = Employee.find_by_role_id(Role.find_by_role("president"))
				if reporting_manager_action == "approved"
					status = "hr_approved"
				else
					status = "hr_rejected"
				end
			when 'president'
				reporting_email = "approved@abc.com"
				if reporting_manager_action == "approved"
					status = "president_approved"
				else
					status = "president_rejected"
				end
			end
			leave_request = self.leave_request.update(status: status)
			if leave_request
				#LeaveRequestMailer.update_status_email(self,reporting_email).deliver_now
			end
		end

end
