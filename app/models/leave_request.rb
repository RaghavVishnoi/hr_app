class LeaveRequest < ApplicationRecord

	before_create :default_values
	after_create :notify_reporting_employee

	belongs_to :employee
	belongs_to :cover, :class_name => :Employee,:foreign_key => "cover_id"
	belongs_to :team_leader, :class_name => :Employee,:foreign_key => "team_lead_id"
	belongs_to :team_manager, :class_name => :Employee,:foreign_key => "team_manager_id"


	scope :team_leader_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee"]).pluck(:id)) }

	scope :team_manager_leave_requests, -> {where(status: ["lead_approved","manager_approved","hr_approved","president_approved","manager_rejected","hr_rejected","president_rejected"]).joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader"]).pluck(:id))}

	scope :hr_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}

	private
		def default_values
			self.status ||= "initial"
		end

		def notify_reporting_employee
			case self.employee.role.role
			when "employee"
				@email = Employee.find_by_role_id(Role.find_by_role("team_leader"))
			when "team_leader"
				@email = Employee.find_by_role_id(Role.find_by_role("team_manager"))
			when "team_manager"
				@email = Employee.find_by_role_id(Role.find_by_role("hr"))
			end				
			LeaveRequestMailer.leave_email(@email,self).deliver_now
		end

end