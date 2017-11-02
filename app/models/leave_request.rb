class LeaveRequest < ApplicationRecord

	LEAVE_REQUEST_FILTER = ["All","Active","Approved","Rejected","Cancelled"]
	LEAVE_REQUEST_STATUS = {"Active" => ["initial"],"Pending" => ["lead_approved","manager_approved"],"Approved" => ["hr_approved","president_approved"],"Rejected" => ["lead_rejected","manager_rejected","hr_rejected","president_rejected"],"Cancelled" => ["lead_cancelled","manager_cancelled","hr_cancelled","president_cancelled"]}

	before_create :default_values
	after_create :notify_reporting_employee
	after_create :update_available_hours
	after_create :notify_cover_employee

	belongs_to :employee
	belongs_to :cover, :class_name => :Employee,:foreign_key => "cover_id"
	belongs_to :team_leader, :class_name => :Employee,:foreign_key => "team_lead_id"
	belongs_to :team_manager, :class_name => :Employee,:foreign_key => "team_manager_id"
	has_many :leave_responses


	scope :team_leader_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_manager"]).pluck(:id))}

	scope :team_manager_leave_requests, -> {where(status: ["lead_approved","manager_approved","hr_approved","president_approved","manager_rejected","hr_rejected","president_rejected","lead_cancelled","manager_cancelled","hr_cancelled","president_cancelled"]).joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}

	scope :hr_leave_requests, -> {joins(:employee).where("employees.role_id in (?)", Role.where(role: ["employee","team_leader","team_manager"]).pluck(:id))}

	validates :from,presence: true
	validates :to,presence: true

	def self.is_approve_disable(status,current_employee)
		case current_employee.user_role
		when 'employee'
			["cover_approved","lead_approved","manager_approved","hr_approved","president_approved"].include? status
		when 'team_leader'
			["lead_approved","manager_approved","hr_approved","president_approved"].include? status
		when 'team_manager'
			["manager_approved","hr_approved","president_approved"].include? status
		when 'hr'
			["hr_approved","president_approved"].include? status
		when 'president'
			["president_approved"].include? status
		end
	end

	def self.is_reject_disable(status,current_employee)
		case current_employee.user_role
		when 'employee'
			["cover_rejected","lead_rejected","manager_rejected","hr_rejected","president_rejected"].include? status
		when 'team_leader'
			["lead_rejected","manager_rejected","hr_rejected","president_rejected"].include? status
		when 'team_manager'
			["manager_rejected","hr_rejected","president_rejected"].include? status
		when 'hr'
			["hr_rejected","president_rejected"].include? status
		when 'president'
			["president_rejected"].include? status
		end
	end

	def self.is_approve_action_available(status,current_employee)
		case current_employee.user_role
		when 'team_leader'
			["initial","cover_approved","cover_rejected","lead_approved","lead_rejected"].include? status
		when 'team_manager'
			["lead_approved","lead_rejected","manager_approved","manager_rejected"].include? status
		when 'hr'
			true
		when 'president'
			true
		end
	end

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
			when "hr"
				@email = Employee.find_by_role_id(Role.find_by_role("president"))
			end				
			#LeaveRequestMailer.leave_email(@email,self).deliver_now
		end

		def notify_cover_employee
			#LeaveRequestMailer.leave_email(self.cover.email,self).deliver_now
		end

		def update_available_hours
			employee_hours = self.employee.employee_hour
			case self.leave_hour_type
			when "Sick"
				sick_hours = employee_hours.try(:available_sick_hours) || 0
				employee_hours.update(available_sick_hours: sick_hours-self.sick_hour_usage) if employee_hours.present?
			when "Vocation"
				available_vocation_hours = employee_hours.try(:available_vocation_hours) || 0
				employee_hours.update(available_vocation_hours: available_vocation_hours-self.vocation_hour_usage) if employee_hours.present?
			else

			end
		end

end
