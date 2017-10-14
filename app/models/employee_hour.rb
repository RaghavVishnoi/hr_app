class EmployeeHour < ApplicationRecord

	belongs_to :employee

	before_create :default_values

	validates :initial_sick_hours,presence: true
	validates :initial_vocation_hours,presence: true


	private
		def default_values
			self.available_sick_hours ||= self.initial_sick_hours
			self.available_vocation_hours ||= self.initial_vocation_hours
		end

end
