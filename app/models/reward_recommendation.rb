class RewardRecommendation < ApplicationRecord

	belongs_to :recommended_employee,class_name: 'Employee',foreign_key: :recommended_employee_id
	belongs_to :employee

	before_create :default_values

	private
		def default_values
			self.status ||= "New"
		end

end
