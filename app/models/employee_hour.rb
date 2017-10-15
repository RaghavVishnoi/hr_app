class EmployeeHour < ApplicationRecord

	belongs_to :employee
	has_many :employee_hour_history

	before_create :default_values
	after_create :update_history

	validates :initial_sick_hours,presence: true
	validates :initial_vocation_hours,presence: true


	private
		def default_values
			self.available_sick_hours ||= self.initial_sick_hours
			self.available_vocation_hours ||= self.initial_vocation_hours
		end

		def update_history
			hour_hostory = self.employee_hour_history.new
			hour_hostory.start_date = Date.current.beginning_of_month
			hour_hostory.end_date = Date.current.end_of_month
			hour_hostory.sick_hours = self.initial_sick_hours
			hour_hostory.vocation_hours = self.initial_vocation_hours
			hour_hostory.save
		end

end
