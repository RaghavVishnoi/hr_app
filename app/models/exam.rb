class Exam < ApplicationRecord
  has_many :responses, through: :questions
  has_many :questions, dependent: :destroy
  scope :enabled, -> { where(:state => true) }
  belongs_to :subject

  belongs_to :team
  has_many :results, dependent: :destroy

  def is_attemted_by(employee)
    results.where(employee_id: employee.id).present?
  end
end
