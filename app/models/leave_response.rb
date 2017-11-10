class LeaveResponse < ApplicationRecord

	attr_accessor :reporting_manager_action
	attr_accessor :reporting_manager_id

	after_create :notify_users

	belongs_to :leave_request
	belongs_to :employee

	private
		def notify_users
			if reporting_manager_action != "forward"
				reporting_email = ""
				status = ""
				reporting_manager_id = 1;
				case self.employee.role.role
				when 'employee'
					reporting_email = self.leave_request.cover.email
					if reporting_manager_action == "approved"
						status = "cover_approved"
						reporting_manager_id = self.leave_request.team_leader.id
					else
						status = "cover_rejected"
						reporting_manager_id = self.leave_request.employee.id
					end
				when 'team_leader'
					reporting_email = self.leave_request.team_manager.email
					if reporting_manager_action == "approved"
						status = "lead_approved"
						reporting_manager_id = self.leave_request.team_manager.id
					elsif reporting_manager_action == "cancel"
						status = "lead_cancelled"
						reporting_manager_id = self.leave_request.employee.id		
					else
						status = "lead_rejected"
						reporting_manager_id = self.leave_request.employee.id
					end
				when "team_manager"
					reporting_employee = Employee.find_by_role_id(Role.find_by_role("hr"))
					reporting_email = reporting_employee.email
					if reporting_manager_action == "approved"
						status = "manager_approved"
						reporting_manager_id = reporting_employee.id
					elsif reporting_manager_action == "cancel"
						status = "manager_cancelled"
						reporting_manager_id = self.leave_request.employee.id		
					else
						status = "manager_rejected"
						reporting_manager_id = self.leave_request.employee.id	
					end
				when 'hr'
					reporting_email = Employee.find_by_role_id(Role.find_by_role("president"))
					if reporting_manager_action == "approved"
						status = "hr_approved"
						reporting_manager_id = self.employee.id
					elsif reporting_manager_action == "cancel"
						status = "hr_cancelled"	
						reporting_manager_id = self.leave_request.employee.id
					else
						status = "hr_rejected"
						reporting_manager_id = self.leave_request.employee.id
					end
				when 'president'
					reporting_email = "approved@abc.com"
					if reporting_manager_action == "approved"
						status = "president_approved"
						reporting_manager_id = self.employee.id
					elsif reporting_manager_action == "cancel"
						status = "president_cancelled"
						reporting_manager_id = self.leave_request.employee.id		
					else
						status = "president_rejected"
						reporting_manager_id = self.leave_request.employee.id
					end
				end
				leave_request = self.leave_request.update(status: status,comment: self.comment,reporting_manager_id: reporting_manager_id)
				if leave_request
					#LeaveRequestMailer.update_status_email(self,reporting_email).deliver_now
					Notification.create!(title: "Need Approval",description: "",redirect_uri: "/leave_requests",notification_type: "leave_request",employee_id: reporting_manager_id) if reporting_manager_id != self.leave_request.employee.id
				end
			end	
		end

end
