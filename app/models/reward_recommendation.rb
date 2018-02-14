class RewardRecommendation < ApplicationRecord

	belongs_to :recommended_employee,class_name: 'Employee',foreign_key: :recommended_employee_id
	belongs_to :employee
	belongs_to :team_leader,class_name: 'Employee',foreign_key: :team_lead_id
	belongs_to :team_manager,class_name: 'Employee',foreign_key: :team_manager_id

	before_create :default_values

	scope :team_leader_reward_recommendation, -> (current_employee) {joins(:employee).where(team_lead_id: current_employee.id).pluck(:id)}

	scope :team_manager_reward_recommendation, -> (current_employee) {where(status: ["lead_approved","manager_approved","hr_approved","president_approved","manager_rejected","hr_rejected","president_rejected","lead_cancelled","manager_cancelled","hr_cancelled","president_cancelled"],team_manager_id: current_employee.id).joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader"]).pluck(:id))}

	
	def can_approve(current_employee)
		case current_employee.role.role
		when 'employee'
			false
		when 'team_leader'
			if ['New','lead_rejected','lead_cancelled'].include? self.status
				true
			else
				false
			end
		when 'team_manager'
			if ['lead_approved','manager_rejected','manager_cancelled'].include? self.status
				true
			else
				false
			end
		when 'hr'
			if ['hr_approved','president_approved'].include? self.status
				false
			else
				true
			end	
		when 'president'
			if ['president_approved'].include? self.status
				false
			else
				true
			end
		end
	end

	def can_reject(current_employee)
		case current_employee.role.role
		when 'employee'
			false
		when 'team_leader'
			if ['New','lead_approved','lead_cancelled'].include? self.status
				true
			else
				false
			end
		when 'team_manager'
			if ['lead_approved','manager_cancelled','manager_approved'].include? self.status
				true
			else
				false
			end
		when 'hr'
			if ['hr_rejected'].include? self.status
				false
			else
				true
			end	
		when 'president'
			if ['president_rejected'].include? self.status
				false
			else
				true
			end
		end
	end

	def can_cancel(current_employee)
		case current_employee.role.role
		when 'employee'
			false
		when 'team_leader'
			if ['New','lead_approved','lead_rejected'].include? self.status
				true
			else
				false
			end
		when 'team_manager'
			if ['lead_approved','manager_approved','manager_rejected'].include? self.status
				true
			else
				false
			end
		when 'hr'
			if ['hr_cancelled'].include? self.status
				false
			else
				true
			end	
		when 'president'
			if ['president_cancelled'].include? self.status
				false
			else
				true
			end
		end
	end

	def self.update_status(reward_recommendation, status, current_employee)
		case status
	    when 'approve'
	      case current_employee.role.role
	      when 'team_leader'
	        status = 'lead_approved'
	      when 'team_manager'
	        status = 'manager_approved'
	      when 'hr'
	      	status = 'hr_approved'
	      when 'president'
	      	status = 'president_approved'
	      end
	    when 'reject'
	      case current_employee.role.role
	      when 'team_leader'
	      	status = 'lead_rejected'
	      when 'team_manager'
	      	status = 'manager_rejected'
	      when 'hr'
	      	status = 'hr_rejected'
	      when 'president'
	      	status = president_rejected
	      end
	    when 'cancel'
	      case current_employee.role.role
	      when 'team_leader'
	      	status = 'lead_cancelled'
	      when 'team_manager'
	      	status = 'manager_cancelled'
	      when 'hr'
	      	status = 'hr_cancelled'
	      when 'president'
	      	status = 'president_cancelled'
	      end
	    end
	    result = reward_recommendation.update_attributes(status: status)
	    if result
	    	{status: 200, message: 'Successfully Updated!'}
	    else
	    	{status: 422, message: reward_recommendation.errors.full_messages}
	    end
	end

	private
		def default_values
			self.status ||= "New"
		end

end
