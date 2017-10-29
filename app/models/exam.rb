class Exam < ApplicationRecord
  has_many :responses, through: :questions
  has_many :questions, dependent: :destroy
  scope :enabled, -> { where(:state => true) }
  belongs_to :subject

  belongs_to :team
  belongs_to :employee
  has_many :results, dependent: :destroy

  def is_attemted_by(employee)
    results.where(employee_id: employee.id).present?
  end

  def is_passed?
  	self.marks >= self.cut_off_marks ? 'Yes' : 'No'
  end
end
