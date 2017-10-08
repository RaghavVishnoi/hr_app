class LeaveRequest < ApplicationRecord

	before_create :default_values

	belongs_to :employee

	scope :team_leader_leave_requests, -> {joins(:employee).where("employee.role_id in (?)", Role.where(role: ["employee"]).pluck(:id)) }

	scope :team_manager_leave_requests, -> {joins(:employee).where("employee.role_id in (?)", Role.where(role: ["employee","team_leader"]).pluck(:id))}

	scope :hr_leave_requests, -> {joins(:employee).where("employee.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}

	private
		def default_values
			self.status ||= "initial"
		end

end
