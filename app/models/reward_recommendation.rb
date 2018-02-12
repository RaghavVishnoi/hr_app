class RewardRecommendation < ApplicationRecord

	belongs_to :recommended_employee,class_name: 'Employee',foreign_key: :recommended_employee_id
	belongs_to :employee

	before_create :default_values

	scope :team_leader_reward_recommendation, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_manager"]).pluck(:id))}

	scope :team_manager_leave_requests, -> (current_employee) {where(status: ["lead_approved","manager_approved","hr_approved","president_approved","manager_rejected","hr_rejected","president_rejected","lead_cancelled","manager_cancelled","hr_cancelled","president_cancelled"],team_manager_id: current_employee.id).joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader"]).pluck(:id))}

	scope :hr_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}

	private
		def default_values
			self.status ||= "New"
		end

end
