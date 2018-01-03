class FlextimeRequest < ApplicationRecord
	belongs_to :employee
	belongs_to :team_lead,class_name: 'Employee',foreign_key: :team_lead_id
	belongs_to :team_manager,class_name: 'Employee',foreign_key: :team_manager_id
	belongs_to :from_employee,class_name: 'Employee',foreign_key: :from
	belongs_to :to_employee,class_name: 'Employee',foreign_key: :to

	scope :team_leader_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_manager"]).pluck(:id))}

	scope :team_manager_leave_requests, -> (current_employee) {where(status: ["lead_approved","manager_approved","hr_approved","president_approved","manager_rejected","hr_rejected","president_rejected","lead_cancelled","manager_cancelled","hr_cancelled","president_cancelled"],team_manager_id: current_employee.id).joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader"]).pluck(:id))}

	scope :hr_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}
end
